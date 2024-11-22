module Clerk
  module StepUp
    PRESETS = {
      strict_mfa:  { after_minutes: 10,   level: :multi_factor  },
      strict:      { after_minutes: 10,   level: :second_factor },
      moderate:    { after_minutes: 60,   level: :second_factor },
      lax:         { after_minutes: 1440, level: :second_factor }
    }
  end
end
