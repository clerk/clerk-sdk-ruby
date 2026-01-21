# frozen_string_literal: true

require 'ostruct'
require 'forwardable'

module Clerk
  # This class represents a parameter object used to contain all request and configuration
  # information required by the middleware to resolve the current request state.
  # link: https://refactoring.guru/introduce-parameter-object
  class AuthenticateContext
    extend Forwardable

    # Expose the url of the request that this parameter object was created from as a URI object.
    attr_reader :clerk_url

    # Expose properties that does not require validations or complex logic to retrieve
    # values by delegating them to the cookies or headers variables.
    def_delegators :@cookies, :session_token_in_cookie, :client_uat
    def_delegators :@headers, :session_token_in_header, :sec_fetch_dest

    # Creates a new parameter object using ::Rack::Request and Clerk::Config objects.
    def initialize(request, config)
      @clerk_url = URI.parse(request.url)
      @config = config

      @cookies = OpenStruct.new({
        client_uat: request.cookies[CLIENT_UAT_COOKIE],
        dev_browser: request.cookies[DEV_BROWSER_COOKIE],
        handshake_token: request.cookies[HANDSHAKE_COOKIE],
        session_token_in_cookie: request.cookies[SESSION_COOKIE]
      })

      @headers = OpenStruct.new({
        accept: Utils.retrieve_header_from_request(request, ACCEPT_HEADER),
        host: request.host,
        origin: Utils.retrieve_header_from_request(request, ORIGIN_HEADER),
        port: request.port,
        sec_fetch_dest: Utils.retrieve_header_from_request(request, SEC_FETCH_DEST_HEADER),
        session_token_in_header: Utils.retrieve_header_from_request(request, AUTHORIZATION_HEADER).gsub(/bearer/i, '').strip
      })
    end

    # The following properties are part of the props supported in all the AuthenticateContext
    # objects across all of our SDKs (eg JS, Go)
    def secret_key
      raise ConfigurationError, 'Clerk secret key is not set' if @config.secret_key.to_s.empty?

      @config.secret_key.to_s
    end

    def publishable_key
      raise ConfigurationError, 'Clerk publishable key is not set' if @config.publishable_key.to_s.to_s.empty?

      @config.publishable_key.to_s
    end

    def proxy_url?
      !proxy_url.empty?
    end

    def handshake_token
      @handshake_token ||= Utils.retrieve_from_query_string(@clerk_url, HANDSHAKE_COOKIE) || @cookies.handshake_token.to_s
    end

    def dev_browser
      @dev_browser ||= dev_browser_in_url || @cookies.dev_browser.to_s
    end

    # The frontend_api returned is without protocol prefix
    def frontend_api
      return '' unless Utils.valid_publishable_key?(publishable_key.to_s)

      @frontend_api ||= if proxy_url?
        proxy_url
      elsif development_instance? && !domain.empty?
        "clerk.#{domain}"
      else
        # remove $ postfix
        Utils.decode_publishable_key(publishable_key).chop.to_s
      end
    end

    def development_instance?
      secret_key.start_with?('sk_test_')
    end

    def production_instance?
      secret_key.start_with?('sk_live_')
    end

    def document_request?
      @headers.sec_fetch_dest == 'document'
    end

    def accepts_html?
      @headers.accept&.start_with?('text/html')
    end

    def eligible_for_multi_domain?
      satellite? && document_request? && !clerk_synced?
    end

    def active_client?
      @cookies.client_uat.to_i.positive?
    end

    def cross_origin_request?
      # origin contains scheme+host and optionally port (omitted if 80 or 443)
      # ref. https://www.rfc-editor.org/rfc/rfc6454#section-6.1
      return false if @headers.origin.nil?

      # strip scheme
      origin = @headers.origin.strip.sub(%r{\A(\w+:)?//}, '')
      return false if origin.empty?

      # Rack's host and port helpers are reverse-proxy-aware; that
      # is, they prefer the de-facto X-Forwarded-* headers if they're set
      request_host = @headers.host
      request_host << ":#{@headers.port}" if @headers.port != 80 && @headers.port != 443

      origin != request_host
    end

    def dev_browser?
      !dev_browser.empty?
    end

    def session_token_in_header?
      !session_token_in_header.to_s.empty?
    end

    def handshake_token?
      !handshake_token.to_s.empty?
    end

    def session_token_in_cookie?
      !session_token_in_cookie.to_s.empty?
    end

    def dev_browser_in_url
      Utils.retrieve_from_query_string(@clerk_url, DEV_BROWSER_COOKIE)
    end

    def dev_browser_in_url?
      !!dev_browser_in_url
    end

    def domain
      '' # TODO: Add multi-domain support
    end

    def satellite?
      false # TODO: Add multi-domain support
    end

    def proxy_url
      '' # TODO: Add multi-domain support
    end

    def clerk_synced?
      false # TODO: Add multi-domain support
    end

    def clerk_redirect_url
      '' # TODO: Add multi-domain support
    end
  end
end
