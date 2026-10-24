# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::Cursor
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::Cursor
  def has_next_page(); end
  def has_next_page=(str_); end
  def starting_after(); end
  def starting_after=(str_); end
  def ending_before(); end
  def ending_before=(str_); end
end
