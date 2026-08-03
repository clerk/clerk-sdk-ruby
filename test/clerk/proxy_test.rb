# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/clerk/constants'
require_relative '../../lib/clerk/proxy'

module Clerk
  class ProxyReverificationTest < Minitest::Test
    def proxy(fva:, extra_claims: {})
      claims = {'sub' => 'user_123'}
      claims['fva'] = fva unless fva == :omitted
      Clerk::Proxy.new(session_claims: claims.merge(extra_claims))
    end

    # A policy that both factors satisfy comfortably, so any failure below comes
    # from the 'fva' handling rather than from the ages themselves.
    def lenient
      {after_minutes: 10, level: :second_factor}
    end

    # --- omitted 'fva' (AISEC-49) ---------------------------------------------

    def test_omitted_fva_is_not_reverified
      %i[first_factor second_factor multi_factor].each do |level|
        p = proxy(fva: :omitted)
        refute p.user_reverified?({after_minutes: 10, level: level}),
               "expected level #{level} to be unsatisfied when 'fva' is omitted"
        assert p.user_needs_reverification?({after_minutes: 10, level: level})
      end
    end

    def test_omitted_fva_fails_every_preset
      [StepUp::Preset::STRICT_MFA, StepUp::Preset::STRICT,
       StepUp::Preset::MODERATE, StepUp::Preset::LAX].each do |preset|
        assert proxy(fva: :omitted).user_needs_reverification?(preset),
               "expected preset #{preset} to require reverification when 'fva' is omitted"
      end
    end

    def test_omitted_fva_yields_to_require_reverification_block
      yielded = false
      proxy(fva: :omitted).user_require_reverification!(StepUp::Preset::STRICT) { yielded = true }
      assert yielded
    end

    def test_explicit_null_fva_is_not_reverified
      refute proxy(fva: nil).user_reverified?(lenient)
    end

    # --- well-formed 'fva' ----------------------------------------------------

    def test_recent_second_factor_satisfies_second_factor_policy
      assert proxy(fva: [0, 0]).user_reverified?({after_minutes: 10, level: :second_factor})
    end

    def test_stale_second_factor_fails_second_factor_policy
      refute proxy(fva: [0, 60]).user_reverified?({after_minutes: 10, level: :second_factor})
    end

    def test_second_factor_policy_falls_back_to_first_when_2fa_not_enabled
      assert proxy(fva: [0, -1]).user_reverified?({after_minutes: 10, level: :second_factor})
      refute proxy(fva: [60, -1]).user_reverified?({after_minutes: 10, level: :second_factor})
    end

    def test_first_factor_not_enabled_fails_levels_that_consult_it
      %i[first_factor multi_factor].each do |level|
        refute proxy(fva: [-1, 0]).user_reverified?({after_minutes: 10, level: level}),
               "expected level #{level} to be unsatisfied when the first factor is not enabled"
      end
    end

    # With 2FA enabled, the :second_factor level rests on the second factor
    # alone and doesn't consult the first. Matches clerk-sdk-go's
    # SessionClaims#NeedsReverification.
    def test_second_factor_level_ignores_first_factor_when_2fa_enabled
      assert proxy(fva: [-1, 0]).user_reverified?({after_minutes: 10, level: :second_factor})
      refute proxy(fva: [-1, 60]).user_reverified?({after_minutes: 10, level: :second_factor})
    end

    def test_multi_factor_requires_both_when_2fa_enabled
      assert proxy(fva: [0, 0]).user_reverified?({after_minutes: 10, level: :multi_factor})
      refute proxy(fva: [0, 60]).user_reverified?({after_minutes: 10, level: :multi_factor})
      refute proxy(fva: [60, 0]).user_reverified?({after_minutes: 10, level: :multi_factor})
    end

    def test_age_equal_to_policy_window_is_stale
      refute proxy(fva: [10, 10]).user_reverified?({after_minutes: 10, level: :second_factor})
      assert proxy(fva: [9, 9]).user_reverified?({after_minutes: 10, level: :second_factor})
    end

    # --- policy and session guards --------------------------------------------

    def test_signed_out_session_is_not_reverified
      refute Clerk::Proxy.new(session_claims: nil).user_reverified?(lenient)
    end

    def test_missing_or_incomplete_policy_is_not_reverified
      [{}, {level: :second_factor}, {after_minutes: 10}].each do |params|
        refute proxy(fva: [0, 0]).user_reverified?(params),
               "expected policy #{params.inspect} to be rejected"
      end
    end

    def test_unrecognized_level_is_not_reverified
      refute proxy(fva: [0, 0]).user_reverified?({after_minutes: 10, level: :third_factor})
    end
  end
end
