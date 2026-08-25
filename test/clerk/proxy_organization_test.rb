# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/clerk/constants'
require_relative '../../lib/clerk/proxy'

module Clerk
  class ProxyOrganizationTest < Minitest::Test
    # Mirrors the generated SDK: Organizations#get requires the organization_id keyword.
    FakeOrganizations = Struct.new(:organization) do
      def get(organization_id:)
        raise ArgumentError, 'unexpected id' unless organization_id == 'org_123'

        Struct.new(:organization).new(organization)
      end
    end

    def test_organization_fetches_using_the_organization_id_keyword
      Clerk.configuration.cache_store = nil

      org = Object.new
      sdk = Struct.new(:organizations).new(FakeOrganizations.new(org))
      proxy = Clerk::Proxy.new(session_claims: {'sub' => 'user_123', 'org_id' => 'org_123'})
      proxy.instance_variable_set(:@sdk, sdk)

      assert_same org, proxy.organization
    end
  end
end
