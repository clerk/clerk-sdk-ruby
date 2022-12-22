class JWKSCache
  def initialize(lifetime)
    @lifetime = lifetime
    @jwks = nil
    @last_update = nil
    @lock = Concurrent::ReadWriteLock.new
  end

  def fetch(sdk, force_refresh: false, kid_not_found: false)
    should_refresh = @lock.with_read_lock do
      @jwks.nil? || @last_update.nil? || force_refresh ||
        (Time.now.to_i-@last_update > @lifetime) ||
        (kid_not_found && Time.now.to_i-@last_update > 300)
    end

    if should_refresh
      @lock.with_write_lock do
        @last_update = Time.now.to_i

        @jwks = begin
          sdk.jwks.all["keys"]
        rescue Clerk::Errors::Base
          nil
        end
      end
    end

    @lock.with_read_lock do
      @jwks
    end
  end
end
