# frozen_string_literal: true

require "logger"
require "net/http"
require "json"

require_relative "resources/allowlist_identifiers"
require_relative "resources/allowlist"
require_relative "resources/clients"
require_relative "resources/emails"
require_relative "resources/sessions"
require_relative "resources/sms_messages"
require_relative "resources/users"

module Clerk
  class Client
    PRODUCTION_BASE_URL = "https://api.clerk.dev/v1/".freeze

    def initialize(api_key: nil, base_url: nil, logger: nil, ssl_verify_mode: nil)
      if logger
        @logger = logger
      else
        @logger = Logger.new("/dev/null", Logger::UNKNOWN)
      end
      base_url = base_url || ENV.fetch("CLERK_API_BASE", PRODUCTION_BASE_URL)
      @base_uri = if !base_url.end_with?("/")
                    URI("#{base_url}/")
                  else
                    URI(base_url)
                  end
      @api_key = api_key || ENV.fetch("CLERK_API_KEY")
      @http = Net::HTTP.new(@base_uri.host, @base_uri.port)
      if @base_uri.scheme == "https"
        @http.use_ssl = true
        if ssl_verify_mode.to_s.upcase == "VERIFY_NONE"
          @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end
    end

    def request(method, path, query: [], body: nil)
      uri = URI.join(@base_uri, path)
      if !query.empty?
        uri.query = URI.encode_www_form(query)
      end
      form = nil
      if body
        form = URI.encode_www_form(body)
      end
      @logger.debug(">>> #{method.to_s.upcase} #{uri}")
      @logger.debug(">>> #{headers}")
      @logger.debug(">>> #{form}")
      response = case method
                 when :get
                   @http.get(uri, headers)
                 when :post
                   @http.post(uri, form , headers)
                 when :patch
                   @http.patch(uri, form, headers)
                 when :delete
                   @http.delete(uri, headers)
                 end
      @logger.debug("<<< #{response.body}")
      if response["Content-Type"] == "application/json"
        JSON.parse(response.body)
      else
        response.body
      end
    end

    def headers
      {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/x-www-form-urlencoded",
        "User-Agent" => "Clerk/#{Clerk::VERSION}; Ruby/#{RUBY_VERSION}"
      }
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

    def emails
      Resources::Emails.new(self)
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
  end
end
