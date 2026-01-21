# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateOrganizationInvitationBulkRequestBody
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateOrganizationInvitationBulkRequestBody
  def email_address(); end
  def email_address=(str_); end
  def role(); end
  def role=(str_); end
  def inviter_user_id(); end
  def inviter_user_id=(str_); end
  def public_metadata(); end
  def public_metadata=(str_); end
  def private_metadata(); end
  def private_metadata=(str_); end
  def redirect_url(); end
  def redirect_url=(str_); end
  def expires_in_days(); end
  def expires_in_days=(str_); end
  def notify(); end
  def notify=(str_); end
end