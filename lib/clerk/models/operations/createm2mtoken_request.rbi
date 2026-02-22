# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateM2MTokenRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateM2MTokenRequest
  def token_format(); end
  def token_format=(str_); end
  def seconds_until_expiration(); end
  def seconds_until_expiration=(str_); end
  def claims(); end
  def claims=(str_); end
end