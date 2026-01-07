# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateApiKeyRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateApiKeyRequest
  def name(); end
  def name=(str_); end
  def subject(); end
  def subject=(str_); end
  def scopes(); end
  def scopes=(str_); end
  def type(); end
  def type=(str_); end
  def description(); end
  def description=(str_); end
  def claims(); end
  def claims=(str_); end
  def created_by(); end
  def created_by=(str_); end
  def seconds_until_expiration(); end
  def seconds_until_expiration=(str_); end
end