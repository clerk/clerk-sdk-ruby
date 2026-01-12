# typed: false

class Clerk::SDKConfiguration
  extend ::Crystalline::MetadataFields::ClassMethods

  def client(); end

  def client=(client); end

  def gen_version(); end

  def gen_version=(gen_version); end

  def hooks(); end

  def hooks=(hooks); end

  def language(); end

  def language=(language); end

  def openapi_doc_version(); end

  def openapi_doc_version=(openapi_doc_version); end

  def retry_config(); end

  def retry_config=(retry_config); end

  def sdk_version(); end

  def sdk_version=(sdk_version); end

  def security_source(); end

  def security_source=(security_source); end

  def server_idx(); end

  def server_idx=(server_idx); end

  def server_params(); end

  def server_params=(server_params); end

  def server_url(); end

  def server_url=(server_url); end

  def timeout(); end

  def timeout=(timeout); end

  def user_agent(); end

  def user_agent=(user_agent); end
end
