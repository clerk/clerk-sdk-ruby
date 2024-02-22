require "ostruct"
require "forwardable"
require "base64"

module Clerk
    ##
    # This class represents a parameter object used to contain all request and configuration
    # information required by the middleware to resolve the current request state.
    # link: https://refactoring.guru/introduce-parameter-object
    class AuthenticateContext
        extend Forwardable

        ##
        # Expose the url of the request that this parameter object was created from as a URI object.
        attr_reader :clerk_url

        ##
        # Expose properties that does not require validations or complex logic to retrieve
        # values by delegating them to the cookies or headers variables.
        def_delegators :@cookies, :session_token_in_cookie, :client_uat
        def_delegators :@headers, :session_token_in_header, :sec_fetch_dest

        ##
        # Creates a new parameter object using Rack::Request and Clerk::Config objects.
        def initialize(request, config)
            @clerk_url = URI.parse(request.url)
            @config = config

            @cookies = OpenStruct.new({
                session_token_in_cookie: request.cookies[SESSION_COOKIE],
                client_uat: request.cookies[CLIENT_UAT_COOKIE],
                handshake_token: request.cookies[HANDSHAKE_COOKIE],
                dev_browser: request.cookies[DEV_BROWSER_COOKIE]
            })

            @headers = OpenStruct.new({
                session_token_in_header: request.env[AUTHORIZATION_HEADER].to_s.gsub(/bearer/i, '').strip,
                sec_fetch_dest: request.env[SEC_FETCH_DEST_HEADER],
                accept: request.env[ACCEPT_HEADER].to_s,
                origin: request.env[ORIGIN_HEADER].to_s,
                host: request.host,
                port: request.port
            })
        end

        ##
        # The following properties are part of the props supported in all the AuthenticateContext
        # objects across all of our SDKs (eg JS, Go)
        def secret_key
            @config.api_key.to_s
        end

        def publishable_key
            @config.publishable_key.to_s
        end

        def domain
            # TODO(dimkl): Add multi-domain support
            ""
        end

        def is_satellite?
            # TODO(dimkl): Add multi-domain support
            false
        end

        def proxy_url
            # TODO(dimkl): Add multi-domain support
            ""
        end

        def handshake_token
            @handshake_token ||= retrieve_from_query_string(@clerk_url, HANDSHAKE_COOKIE) || @cookies.handshake_token.to_s
        end

        def clerk_synced?
            # TODO(dimkl): Add multi-domain support
            false
        end

        def clerk_redirect_url
             # TODO(dimkl): Add multi-domain support
             ""
        end

        def dev_browser
            @dev_browser ||= retrieve_from_query_string(@clerk_url, DEV_BROWSER_COOKIE) || @cookies.dev_browser.to_s
        end

        # The frontend_api returned is without protocol prefix
        def frontend_api
            return "" if !valid_publishable_key?(publishable_key.to_s)

            @frontend_api ||= if !proxy_url.empty?
                proxy_url
            elsif development_instance? && !domain.empty?
                "clerk.#{domain}"
            else
                # remove $ postfix
                decode_publishable_key(publishable_key).chop
            end
        end

        def development_instance?
            # TODO(dimkl): Consolidate with @clerk/backend to use pk instead of sk
            secret_key.start_with?("sk_test_")
        end

        def production_instance?
            # TODO(dimkl): Consolidate with @clerk/backend to use pk instead of sk
            secret_key.start_with?("sk_live_")
        end

        def document_request?
            @headers.sec_fetch_dest == "document"
        end

        def accepts_html?
            @headers.accept && @headers.accept.start_with?('text/html')
        end
        
        def eligible_for_multi_domain?
            is_satellite? && document_request? && !clerk_synced?
        end

        def active_client?
            @cookies.client_uat.to_i > 0
        end

        def cross_origin_request?
            # origin contains scheme+host and optionally port (omitted if 80 or 443)
            # ref. https://www.rfc-editor.org/rfc/rfc6454#section-6.1
            return false if @headers.origin.nil?
      
            # strip scheme
            origin = @headers.origin.strip.sub(/\A(\w+:)?\/\//, '')
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

        private

        def valid_publishable_key?(pk)
            valid_publishable_key_prefix?(pk) && valid_publishable_key_postfix?(pk)
        end

        def valid_publishable_key_prefix?(pk)
            pk.start_with?("pk_live_") || pk.start_with?("pk_test_")
        end

        def valid_publishable_key_postfix?(pk)
            decode_publishable_key(pk).end_with?("$")
        end

        def decode_publishable_key(pk)
            Base64.decode64(pk.split("_")[2].to_s)
        end

        def retrieve_from_query_string(url, key)
            Rack::Utils.parse_query(url.query)[key]
        end
    end
end