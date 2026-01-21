# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateBulkInvitationsRequestBody
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateBulkInvitationsRequestBody
  def email_address(); end
  def email_address=(str_); end
  def public_metadata(); end
  def public_metadata=(str_); end
  def redirect_url(); end
  def redirect_url=(str_); end
  def expires_in_days(); end
  def expires_in_days=(str_); end
  def template_slug(); end
  def template_slug=(str_); end
  def notify(); end
  def notify=(str_); end
  def ignore_existing(); end
  def ignore_existing=(str_); end
end