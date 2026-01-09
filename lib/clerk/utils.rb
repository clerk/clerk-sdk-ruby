# frozen_string_literal: true

require 'base64'

module Clerk
  module Utils
    class << self
      def decode_publishable_key(publishable_key)
        Base64.decode64(publishable_key.split('_')[2].to_s)
      end

      def filter_routes(routes)
        filtered_routes = {}
        filtered_wildcard_routes = []

        routes.each do |route|
          route = route.strip

          if route.end_with?('/*')
            filtered_wildcard_routes << route[0..-2]
          else
            filtered_routes[route] = true
          end
        end

        filtered_wildcard_routes.uniq!

        [filtered_routes, filtered_wildcard_routes]
      end

      def retrieve_header_from_request(request, key)
        (request.env[key] || request.env[key.downcase]).to_s
      end

      def retrieve_from_query_string(url, key)
        ::Rack::Utils.parse_query(url.query)[key]
      end

      def valid_publishable_key?(publishable_key)
        raise ArgumentError, 'publishable_key must be a string' unless publishable_key.is_a?(String)

        key = publishable_key.to_s
        valid_publishable_key_prefix?(key) && valid_publishable_key_postfix?(key)
      end

      def valid_publishable_key_postfix?(publishable_key)
        decode_publishable_key(publishable_key).end_with?('$')
      end

      def valid_publishable_key_prefix?(publishable_key)
        publishable_key.start_with?('pk_live_', 'pk_test_')
      end

      # NOTE: This is a copy of Rack::Utils.parse_cookies_header to allow for
      # compatibility with older versions of Rack.
      def parse_cookies_header(value)
        return {} unless value

        value.split(/; */n).each_with_object({}) do |cookie, cookies|
          next if cookie.empty?
          key, value = cookie.split('=', 2)
          next if cookies.key?(key)

          cookies[key] = begin
            unescape(value)
          rescue StandardError
            value
          end
        end
      end

      private 

      def unescape(s, encoding = Encoding::UTF_8)
        URI.decode_www_form_component(s, encoding)
      end
    end
  end
end
