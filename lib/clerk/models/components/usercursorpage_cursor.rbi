# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::UserCursorPageCursor
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::UserCursorPageCursor
  def has_next_page(); end
  def has_next_page=(str_); end
  def starting_after(); end
  def starting_after=(str_); end
  def ending_before(); end
  def ending_before=(str_); end
  def remaining_count_exact(); end
  def remaining_count_exact=(str_); end
  def remaining_count_at_least(); end
  def remaining_count_at_least=(str_); end
end
