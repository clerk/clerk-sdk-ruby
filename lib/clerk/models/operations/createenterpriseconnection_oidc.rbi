# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateEnterpriseConnectionOidc
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateEnterpriseConnectionOidc
  def client_id(); end
  def client_id=(str_); end
  def client_secret(); end
  def client_secret=(str_); end
  def discovery_url(); end
  def discovery_url=(str_); end
  def auth_url(); end
  def auth_url=(str_); end
  def token_url(); end
  def token_url=(str_); end
  def user_info_url(); end
  def user_info_url=(str_); end
  def requires_pkce(); end
  def requires_pkce=(str_); end
end
