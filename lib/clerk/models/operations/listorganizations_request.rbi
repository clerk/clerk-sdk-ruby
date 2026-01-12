# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::ListOrganizationsRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::ListOrganizationsRequest
  def include_members_count(); end
  def include_members_count=(str_); end
  def include_missing_member_with_elevated_permissions(); end
  def include_missing_member_with_elevated_permissions=(str_); end
  def query(); end
  def query=(str_); end
  def user_id(); end
  def user_id=(str_); end
  def organization_id(); end
  def organization_id=(str_); end
  def order_by(); end
  def order_by=(str_); end
  def limit(); end
  def limit=(str_); end
  def offset(); end
  def offset=(str_); end
end