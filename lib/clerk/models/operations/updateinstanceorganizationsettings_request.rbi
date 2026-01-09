# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::UpdateInstanceOrganizationSettingsRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::UpdateInstanceOrganizationSettingsRequest
  def domains_enrollment_modes(); end
  def domains_enrollment_modes=(str_); end
  def enabled(); end
  def enabled=(str_); end
  def max_allowed_memberships(); end
  def max_allowed_memberships=(str_); end
  def admin_delete_enabled(); end
  def admin_delete_enabled=(str_); end
  def domains_enabled(); end
  def domains_enabled=(str_); end
  def slug_disabled(); end
  def slug_disabled=(str_); end
  def creator_role_id(); end
  def creator_role_id=(str_); end
  def domains_default_role_id(); end
  def domains_default_role_id=(str_); end
end