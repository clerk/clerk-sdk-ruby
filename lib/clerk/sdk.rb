# frozen_string_literal: true

require "faraday"
require "logger"
require "net/http"
require "json"
require "jwt"
require "concurrent-ruby"

require_relative "resources/allowlist_identifiers"
require_relative "resources/allowlist"
require_relative "resources/clients"
require_relative "resources/email_addresses"
require_relative "resources/emails"
require_relative "resources/organizations"
require_relative "resources/phone_numbers"
require_relative "resources/sessions"
require_relative "resources/sms_messages"
require_relative "resources/users"
require_relative "resources/users"
require_relative "resources/jwks"
require_relative "errors"
require_relative "jwks_cache"

module Clerk
  class SDK
    DEFAULT_HEADERS = {
      "User-Agent" => "Clerk/#{Clerk::VERSION}; Faraday/#{Faraday::VERSION}; Ruby/#{RUBY_VERSION}",
      "X-Clerk-SDK" => "ruby/#{Clerk::VERSION}"
    }

    # How often (in seconds) should JWKs be refreshed
    JWKS_CACHE_LIFETIME = 3600 # 1 hour

    @@jwks_cache = JWKSCache.new(JWKS_CACHE_LIFETIME)

    def self.jwks_cache
      @@jwks_cache
    end

    def initialize(api_key: nil, base_url: nil, logger: nil, ssl_verify: true,
                   connection: nil)
      if connection # Inject a Faraday::Connection for testing or full control over Faraday
        @conn = connection
        return
      else
        base_url = base_url || Clerk.configuration.base_url
        base_uri = if !base_url.end_with?("/")
                     URI("#{base_url}/")
                   else
                     URI(base_url)
                   end
        api_key = api_key || Clerk.configuration.api_key
        logger = logger || Clerk.configuration.logger
        @conn = Faraday.new(
          url: base_uri, headers: DEFAULT_HEADERS, ssl: {verify: ssl_verify}
        ) do |f|
          f.request :url_encoded
          f.request :authorization, "Bearer", api_key
          if logger
            f.response :logger, logger do |l|
              l.filter(/(Authorization: "Bearer) (\w+)/, '\1 [SECRET]')
            end
          end
        end
      end
    end

    def request(method, path, query: [], body: nil, timeout: nil)
      response = case method
                 when :get
                   @conn.get(path, query) do |req|
                     req.options.timeout = timeout if timeout
                   end
                 when :post
                   @conn.post(path, body) do |req|
                     req.body = body.to_json
                     req.headers[:content_type] = "application/json"
                     req.options.timeout = timeout if timeout
                   end
                 when :patch
                   @conn.patch(path, body) do |req|
                     req.body = body.to_json
                     req.headers[:content_type] = "application/json"
                     req.options.timeout = timeout if timeout
                   end
                 when :delete
                   @conn.delete(path) do |req|
                     req.options.timeout = timeout if timeout
                   end
                 end

      body = if response["Content-Type"] == "application/json"
               JSON.parse(response.body)
             else
               response.body
             end

      if response.success?
        body
      else
        klass = case body.dig("errors", 0, "code")
                when "cookie_invalid", "client_not_found", "resource_not_found"
                  Errors::Authentication
                else
                  Errors::Fatal
                end
        raise klass.new(body, status: response.status)
      end
    end

    def allowlist_identifiers
      Resources::AllowlistIdentifiers.new(self)
    end

    def allowlist
      Resources::Allowlist.new(self)
    end

    def clients
      Resources::Clients.new(self)
    end

    def email_addresses
      Resources::EmailAddresses.new(self)
    end

    def emails
      Resources::Emails.new(self)
    end

    def organizations
      Resources::Organizations.new(self)
    end

    def phone_numbers
      Resources::PhoneNumbers.new(self)
    end

    def sessions
      Resources::Sessions.new(self)
    end

    def sms_messages
      Resources::SMSMessages.new(self)
    end

    def users
      Resources::Users.new(self)
    end

    def jwks
      Resources::JWKS.new(self)
    end

    def interstitial(refresh=false)
      request(:get, "internal/interstitial")
    end

    # Returns the decoded JWT payload without verifying if the signature is
    # valid.
    #
    # WARNING: This will not verify whether the signature is valid. You
    # should not use this for untrusted messages! You most likely want to use
    # verify_token.
    def decode_token(token)
      JWT.decode(token, nil, false).first
    end

    # Decode the JWT and verify it's valid (verify claims, signature etc.) using
    # the provided algorithms.
    #
    # JWKS are cached for JWKS_CACHE_LIFETIME seconds, in order to avoid
    # unecessary roundtrips. In order to invalidate the cache, pass
    # `force_refresh_jwks: true`.
    #
    # A timeout for the request to the JWKs endpoint can be set with the
    # `timeout` argument.
    def verify_token(token, force_refresh_jwks: false, algorithms: ['RS256'], timeout: 5)
      jwk_loader = ->(options) do
        # JWT.decode requires that the 'keys' key in the Hash is a symbol (as
        # opposed to a string which our SDK returns by default)
        { keys: SDK.jwks_cache.fetch(self, kid_not_found: (options[:invalidate] || options[:kid_not_found]), force_refresh: force_refresh_jwks) }
      end

      JWT.decode(token, nil, true, algorithms: algorithms, jwks: jwk_loader).first
    end
  end
end
