# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreatePhoneNumberRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreatePhoneNumberRequest
  def user_id(); end
  def user_id=(str_); end
  def phone_number(); end
  def phone_number=(str_); end
  def verified(); end
  def verified=(str_); end
  def primary(); end
  def primary=(str_); end
  def reserved_for_second_factor(); end
  def reserved_for_second_factor=(str_); end
end