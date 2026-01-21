# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::Credit
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::Credit
  def cycle_remaining_percent(); end
  def cycle_remaining_percent=(str_); end
  def amount(); end
  def amount=(str_); end
end