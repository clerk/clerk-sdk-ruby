# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::UpdateUserRequestBody
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::UpdateUserRequestBody
  def password_digest(); end
  def password_digest=(str_); end
  def password_hasher(); end
  def password_hasher=(str_); end
  def backup_codes(); end
  def backup_codes=(str_); end
  def external_id(); end
  def external_id=(str_); end
  def first_name(); end
  def first_name=(str_); end
  def last_name(); end
  def last_name=(str_); end
  def locale(); end
  def locale=(str_); end
  def primary_email_address_id(); end
  def primary_email_address_id=(str_); end
  def primary_phone_number_id(); end
  def primary_phone_number_id=(str_); end
  def primary_web3_wallet_id(); end
  def primary_web3_wallet_id=(str_); end
  def username(); end
  def username=(str_); end
  def profile_image_id(); end
  def profile_image_id=(str_); end
  def password(); end
  def password=(str_); end
  def skip_password_checks(); end
  def skip_password_checks=(str_); end
  def sign_out_of_other_sessions(); end
  def sign_out_of_other_sessions=(str_); end
  def totp_secret(); end
  def totp_secret=(str_); end
  def public_metadata(); end
  def public_metadata=(str_); end
  def private_metadata(); end
  def private_metadata=(str_); end
  def unsafe_metadata(); end
  def unsafe_metadata=(str_); end
  def delete_self_enabled(); end
  def delete_self_enabled=(str_); end
  def create_organization_enabled(); end
  def create_organization_enabled=(str_); end
  def legal_accepted_at(); end
  def legal_accepted_at=(str_); end
  def skip_legal_checks(); end
  def skip_legal_checks=(str_); end
  def create_organizations_limit(); end
  def create_organizations_limit=(str_); end
  def created_at(); end
  def created_at=(str_); end
  def bypass_client_trust(); end
  def bypass_client_trust=(str_); end
  def notify_primary_email_address_changed(); end
  def notify_primary_email_address_changed=(str_); end
end