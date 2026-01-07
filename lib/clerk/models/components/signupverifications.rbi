# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::SignUpVerifications
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::SignUpVerifications
  def email_address(); end
  def email_address=(str_); end
  def phone_number(); end
  def phone_number=(str_); end
  def web3_wallet(); end
  def web3_wallet=(str_); end
  def external_account(); end
  def external_account=(str_); end
end