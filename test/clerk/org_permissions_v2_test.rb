# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/clerk'

module Clerk
  # Coverage for Clerk::SDK#compute_org_permissions_from_v2_token, which decodes
  # the `fea` / `o.per` / `o.fpm` triple of a v2 session token into
  # `org:<feature>:<action>` strings.
  class OrgPermissionsV2Test < Minitest::Test
    ACTIONS = (0...64).map { |n| "act_#{n}" }.freeze

    def sdk
      @sdk ||= Clerk::SDK.new(secret_key: 'sk_test_not_used')
    end

    def permissions_for(fea:, per:, fpm:)
      claims = {'fea' => fea, 'o' => {'per' => per, 'fpm' => fpm}}
      sdk.send(:compute_org_permissions_from_v2_token, claims)
    end

    # --- happy path (regression guard) ----------------------------------------

    def test_small_masks_decode_with_bit_zero_least_significant
      result = permissions_for(
        fea: 'o:leads,o:whatsapp',
        per: 'chat_read,chat_send,connect,view_history',
        fpm: '3,10'
      )

      assert_equal ['org:leads:chat_read', 'org:leads:chat_send',
                    'org:whatsapp:chat_send', 'org:whatsapp:view_history'], result
    end

    def test_zero_mask_grants_nothing
      assert_empty permissions_for(fea: 'o:leads', per: 'chat_read,chat_send', fpm: '0')
    end

    def test_non_org_scoped_features_are_skipped
      result = permissions_for(
        fea: 'u:billing,o:leads',
        per: 'chat_read,chat_send',
        fpm: '3,1'
      )

      assert_equal ['org:leads:chat_read'], result
    end

    # --- wide masks ------------------------------------------------------------

    def test_mask_with_bit_62_set
      result = permissions_for(fea: 'o:leads', per: ACTIONS.join(','), fpm: (2**62).to_s)

      assert_equal ['org:leads:act_62'], result
    end

    def test_positive_bignum_mask_with_bit_63_set
      # 2**63 + 1 -- above the signed 64-bit range, but Ruby Integers are
      # arbitrary-precision so this must still decode to indices 0 and 63.
      result = permissions_for(fea: 'o:leads', per: ACTIONS.join(','), fpm: '9223372036854775809')

      assert_equal ['org:leads:act_0', 'org:leads:act_63'], result
    end

    # --- the security regression: negative masks must fail closed --------------

    def test_negative_mask_grants_nothing
      # A signed 64-bit overflow on the producing side yields a negative mask.
      # `(-9223372036854775807).to_s(2)` is "-111...1", which -- walked character
      # by character -- would otherwise grant 63 permissions.
      result = permissions_for(fea: 'o:leads', per: ACTIONS.join(','), fpm: '-9223372036854775807')

      assert_empty result
    end

    def test_negative_mask_does_not_affect_other_features
      result = permissions_for(
        fea: 'o:leads,o:whatsapp',
        per: ACTIONS.join(','),
        fpm: '3,-9223372036854775807'
      )

      assert_equal ['org:leads:act_0', 'org:leads:act_1'], result
    end

    def test_non_numeric_masks_grant_nothing
      ['abc', '1e3', '0x10', ' 3', '3 ', '1.5', '+3', ''].each do |mask|
        assert_empty permissions_for(fea: 'o:leads', per: ACTIONS.join(','), fpm: mask),
                     "expected mask #{mask.inspect} to grant nothing"
      end
    end

    # --- malformed claims must not raise ---------------------------------------

    def test_more_mappings_than_features_does_not_raise
      result = permissions_for(fea: 'o:leads', per: 'chat_read,chat_send', fpm: '1,3,7')

      assert_equal ['org:leads:chat_read'], result
    end

    def test_feature_without_a_scope_separator_does_not_raise
      result = permissions_for(fea: 'leads,o:whatsapp', per: 'chat_read', fpm: '1,1')

      assert_equal ['org:whatsapp:chat_read'], result
    end

    def test_missing_claims_do_not_raise
      assert_empty permissions_for(fea: nil, per: nil, fpm: nil)
      assert_empty permissions_for(fea: 'o:leads', per: nil, fpm: '3')
      assert_empty permissions_for(fea: nil, per: 'chat_read', fpm: '3')
    end

    # --- masks wider than the permission vocabulary ----------------------------

    def test_mask_wider_than_permission_list_does_not_emit_empty_permissions
      # 0b1111 against a two-action vocabulary: only the first two bits map.
      result = permissions_for(fea: 'o:leads', per: 'chat_read,chat_send', fpm: '15')

      assert_equal ['org:leads:chat_read', 'org:leads:chat_send'], result
      refute(result.any? { |permission| permission.end_with?(':') },
             "expected no permissions with an empty action name, got #{result.inspect}")
    end

    def test_high_bit_beyond_permission_list_is_ignored
      result = permissions_for(fea: 'o:leads', per: 'chat_read', fpm: (2**63 | 1).to_s)

      assert_equal ['org:leads:chat_read'], result
    end
  end
end
