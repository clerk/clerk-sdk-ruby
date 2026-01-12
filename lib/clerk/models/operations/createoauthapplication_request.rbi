# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateOAuthApplicationRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateOAuthApplicationRequest
  def name(); end
  def name=(str_); end
  def redirect_uris(); end
  def redirect_uris=(str_); end
  def callback_url(); end
  def callback_url=(str_); end
  def public(); end
  def public=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def consent_screen_enabled(); end
  def consent_screen_enabled=(str_); end
  def pkce_required(); end
  def pkce_required=(str_); end
end