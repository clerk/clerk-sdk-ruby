# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::ListAllOrganizationDomainsRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::ListAllOrganizationDomainsRequest
  def organization_id(); end
  def organization_id=(str_); end
  def verified(); end
  def verified=(str_); end
  def enrollment_mode(); end
  def enrollment_mode=(str_); end
  def query(); end
  def query=(str_); end
  def domains(); end
  def domains=(str_); end
  def order_by(); end
  def order_by=(str_); end
  def offset(); end
  def offset=(str_); end
  def limit(); end
  def limit=(str_); end
end