# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::OrganizationSettings
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::OrganizationSettings
  def object(); end
  def object=(str_); end
  def enabled(); end
  def enabled=(str_); end
  def max_allowed_memberships(); end
  def max_allowed_memberships=(str_); end
  def max_allowed_roles(); end
  def max_allowed_roles=(str_); end
  def creator_role(); end
  def creator_role=(str_); end
  def admin_delete_enabled(); end
  def admin_delete_enabled=(str_); end
  def domains_enabled(); end
  def domains_enabled=(str_); end
  def domains_enrollment_modes(); end
  def domains_enrollment_modes=(str_); end
  def domains_default_role(); end
  def domains_default_role=(str_); end
  def max_role_sets_allowed(); end
  def max_role_sets_allowed=(str_); end
  def max_allowed_permissions(); end
  def max_allowed_permissions=(str_); end
  def slug_disabled(); end
  def slug_disabled=(str_); end
  def initial_role_set_key(); end
  def initial_role_set_key=(str_); end
end