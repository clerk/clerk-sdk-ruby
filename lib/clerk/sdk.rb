# frozen_string_literal: true

require "faraday"
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
require_relative "errors"

module Clerk
  class SDK
    DEFAULT_HEADERS = {
      "User-Agent" => "Clerk/#{Clerk::VERSION}; Faraday/#{Faraday::VERSION}; Ruby/#{RUBY_VERSION}"
    }

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

    def request(method, path, query: [], body: nil)
      response = case method
                 when :get
                   @conn.get(path, query)
                 when :post
                   @conn.post(path, body)
                 when :patch
                   @conn.patch(path, body)
                 when :delete
                   @conn.delete(path)
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
