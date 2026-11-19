# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::LogListCursor
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::LogListCursor
  def has_next_page(); end
  def has_next_page=(str_); end
  def next_page_status(); end
  def next_page_status=(str_); end
  def retention_limit_reached(); end
  def retention_limit_reached=(str_); end
  def retention_days(); end
  def retention_days=(str_); end
  def retention_floor(); end
  def retention_floor=(str_); end
  def searched_from(); end
  def searched_from=(str_); end
  def searched_to(); end
  def searched_to=(str_); end
  def starting_after(); end
  def starting_after=(str_); end
  def ending_before(); end
  def ending_before=(str_); end
end
