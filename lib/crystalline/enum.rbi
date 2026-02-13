# typed: true

module Crystalline
  module Enum
    mixes_in_class_methods(ClassMethods)

    module ClassMethods
      def enums(&blk); end
      def open!; end
      def open?; end
      def deserialize(val); end
    end

    def serialize; end
    def known?; end
  end
end
