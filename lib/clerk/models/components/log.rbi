# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::Log
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::Log
  def level(); end
  def level=(str_); end
  def message(); end
  def message=(str_); end
  def code(); end
  def code=(str_); end
  def short_message(); end
  def short_message=(str_); end
end
