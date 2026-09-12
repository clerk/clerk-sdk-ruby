# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::OAuthApplicationSettings
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::OAuthApplicationSettings
  def object(); end
  def object=(str_); end
  def dynamic_oauth_client_registration(); end
  def dynamic_oauth_client_registration=(str_); end
  def oauth_jwt_access_tokens(); end
  def oauth_jwt_access_tokens=(str_); end
  def aud_claim_enabled(); end
  def aud_claim_enabled=(str_); end
  def pkce_required(); end
  def pkce_required=(str_); end
  def client_id_metadata_documents_advertised(); end
  def client_id_metadata_documents_advertised=(str_); end
  def client_id_metadata_documents_only_allow_pre_registered_clients(); end
  def client_id_metadata_documents_only_allow_pre_registered_clients=(str_); end
  def client_id_metadata_documents_block_implicitly_allowed_clients(); end
  def client_id_metadata_documents_block_implicitly_allowed_clients=(str_); end
  def default_scopes(); end
  def default_scopes=(str_); end
end
