# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateEnterpriseConnectionSaml
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateEnterpriseConnectionSaml
  def idp_entity_id(); end
  def idp_entity_id=(str_); end
  def idp_sso_url(); end
  def idp_sso_url=(str_); end
  def idp_certificate(); end
  def idp_certificate=(str_); end
  def idp_metadata_url(); end
  def idp_metadata_url=(str_); end
  def idp_metadata(); end
  def idp_metadata=(str_); end
  def attribute_mapping(); end
  def attribute_mapping=(str_); end
  def allow_subdomains(); end
  def allow_subdomains=(str_); end
  def allow_idp_initiated(); end
  def allow_idp_initiated=(str_); end
  def force_authn(); end
  def force_authn=(str_); end
end
