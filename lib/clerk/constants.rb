module Clerk
    SESSION_COOKIE = "__session".freeze
    CLIENT_UAT_COOKIE = "__client_uat".freeze
    
    # Dev Browser
    DEV_BROWSER_COOKIE = "__clerk_db_jwt".freeze

    # Handshake
    HANDSHAKE_COOKIE = "__clerk_handshake".freeze
    HANDSHAKE_COOKIE_DIRECTIVES_KEY = "handshake".freeze

    # auth debug response headers
    AUTH_STATUS_HEADER = "X-Clerk-Auth-Status".freeze
    AUTH_REASON_HEADER = "X-Clerk-Auth-Reason".freeze
    AUTH_MESSAGE_HEADER = "X-Clerk-Auth-Message".freeze

    #
    CONTENT_TYPE_HEADER = "Content-Type".freeze
    SEC_FETCH_DEST_HEADER = "HTTP_SEC_FETCH_DEST".freeze
    
    # headers used in response - should be lowered case and without http prefix
    LOCATION_HEADER = "Location".freeze
    COOKIE_HEADER = "Set-Cookie".freeze

    # clerk url related headers
    AUTHORIZATION_HEADER = "HTTP_AUTHORIZATION".freeze
    ACCEPT_HEADER = "HTTP_ACCEPT".freeze
    USER_AGENT_HEADER = "HTTP_USER_AGENT".freeze
    ORIGIN_HEADER = "HTTP_ORIGIN".freeze

    module TokenVerificationErrorReason
        TOKEN_INVALID = "token-invalid".freeze
        TOKEN_EXPIRED = "token-expired".freeze
        TOKEN_NOT_ACTIVE_YET = "token-not-active-yet".freeze
        JWK_FAILED_TO_RESOLVE = "jwk-failed-to-resolve".freeze
    end

    module AuthErrorReason
        CLIENT_UAT_WITHOUT_SESSION_TOKEN = "client-uat-but-no-session-token".freeze
        DEV_BROWSER_SYNC = "dev-browser-sync".freeze
        PRIMARY_RESPONDS_TO_SYNCING = "primary-responds-to-syncing".freeze
        SATELLITE_COOKIE_NEEDS_SYNCING = "satellite-needs-syncing".freeze
        SESSION_TOKEN_AND_UAT_MISSING = "session-token-and-uat-missing".freeze
        SESSION_TOKEN_MISSING = "session-token-missing".freeze
        SESSION_TOKEN_OUTDATED = "session-token-outdated".freeze
        SESSION_TOKEN_WITHOUT_CLIENT_UAT = "session-token-but-no-client-uat".freeze
        UNEXPECTED_ERROR = "unexpected-error".freeze
    end
end