# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateUserRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateUserRequest
  def email_address(); end
  def email_address=(str_); end
  def phone_number(); end
  def phone_number=(str_); end
  def web3_wallet(); end
  def web3_wallet=(str_); end
  def password_hasher(); end
  def password_hasher=(str_); end
  def backup_codes(); end
  def backup_codes=(str_); end
  def public_metadata(); end
  def public_metadata=(str_); end
  def private_metadata(); end
  def private_metadata=(str_); end
  def unsafe_metadata(); end
  def unsafe_metadata=(str_); end
  def external_id(); end
  def external_id=(str_); end
  def first_name(); end
  def first_name=(str_); end
  def last_name(); end
  def last_name=(str_); end
  def locale(); end
  def locale=(str_); end
  def username(); end
  def username=(str_); end
  def password(); end
  def password=(str_); end
  def password_digest(); end
  def password_digest=(str_); end
  def skip_password_checks(); end
  def skip_password_checks=(str_); end
  def skip_password_requirement(); end
  def skip_password_requirement=(str_); end
  def totp_secret(); end
  def totp_secret=(str_); end
  def delete_self_enabled(); end
  def delete_self_enabled=(str_); end
  def legal_accepted_at(); end
  def legal_accepted_at=(str_); end
  def skip_legal_checks(); end
  def skip_legal_checks=(str_); end
  def skip_user_requirement(); end
  def skip_user_requirement=(str_); end
  def create_organization_enabled(); end
  def create_organization_enabled=(str_); end
  def create_organizations_limit(); end
  def create_organizations_limit=(str_); end
  def created_at(); end
  def created_at=(str_); end
  def bypass_client_trust(); end
  def bypass_client_trust=(str_); end
end