# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::GetOrganizationRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::GetOrganizationRequest
  def organization_id(); end
  def organization_id=(str_); end
  def include_members_count(); end
  def include_members_count=(str_); end
  def include_missing_member_with_elevated_permissions(); end
  def include_missing_member_with_elevated_permissions=(str_); end
end