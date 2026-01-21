# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::ListOrganizationInvitationsRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::ListOrganizationInvitationsRequest
  def organization_id(); end
  def organization_id=(str_); end
  def status(); end
  def status=(str_); end
  def email_address(); end
  def email_address=(str_); end
  def order_by(); end
  def order_by=(str_); end
  def limit(); end
  def limit=(str_); end
  def offset(); end
  def offset=(str_); end
end