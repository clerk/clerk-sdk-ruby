# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::LogSchema
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::LogSchema
  def object(); end
  def object=(str_); end
  def event_type(); end
  def event_type=(str_); end
  def fields_(); end
  def fields_=(str_); end
  def description(); end
  def description=(str_); end
  def severity(); end
  def severity=(str_); end
  def docs_group(); end
  def docs_group=(str_); end
  def matched_event_types(); end
  def matched_event_types=(str_); end
end
