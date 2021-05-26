module Clerk
  module Errors
    class Base < StandardError
      attr_reader :status

      def initialize(msg, status:)
        @errors = msg["errors"]
        @status = status
        super(msg.merge("status" => status))
      end
    end

    class Fatal < Base
    end

    class Authentication < Base
    end
  end
end
