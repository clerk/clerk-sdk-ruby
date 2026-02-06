# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::GetUserListRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::GetUserListRequest
  def email_address(); end
  def email_address=(str_); end
  def phone_number(); end
  def phone_number=(str_); end
  def external_id(); end
  def external_id=(str_); end
  def username(); end
  def username=(str_); end
  def web3_wallet(); end
  def web3_wallet=(str_); end
  def user_id(); end
  def user_id=(str_); end
  def organization_id(); end
  def organization_id=(str_); end
  def query(); end
  def query=(str_); end
  def email_address_query(); end
  def email_address_query=(str_); end
  def phone_number_query(); end
  def phone_number_query=(str_); end
  def username_query(); end
  def username_query=(str_); end
  def name_query(); end
  def name_query=(str_); end
  def banned(); end
  def banned=(str_); end
  def last_active_at_before(); end
  def last_active_at_before=(str_); end
  def last_active_at_after(); end
  def last_active_at_after=(str_); end
  def last_active_at_since(); end
  def last_active_at_since=(str_); end
  def created_at_before(); end
  def created_at_before=(str_); end
  def created_at_after(); end
  def created_at_after=(str_); end
  def last_sign_in_at_before(); end
  def last_sign_in_at_before=(str_); end
  def last_sign_in_at_after(); end
  def last_sign_in_at_after=(str_); end
  def provider(); end
  def provider=(str_); end
  def provider_user_id(); end
  def provider_user_id=(str_); end
  def limit(); end
  def limit=(str_); end
  def offset(); end
  def offset=(str_); end
  def order_by(); end
  def order_by=(str_); end
end