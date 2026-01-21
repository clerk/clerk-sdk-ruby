# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::InstanceRestrictions
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::InstanceRestrictions
  def object(); end
  def object=(str_); end
  def allowlist(); end
  def allowlist=(str_); end
  def blocklist(); end
  def blocklist=(str_); end
  def allowlist_blocklist_disabled_on_sign_in(); end
  def allowlist_blocklist_disabled_on_sign_in=(str_); end
  def block_email_subaddresses(); end
  def block_email_subaddresses=(str_); end
  def block_disposable_email_domains(); end
  def block_disposable_email_domains=(str_); end
end