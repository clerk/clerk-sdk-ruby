# typed: false
# frozen_string_literal: true


class Clerk::Models::Operations::CreateJWTTemplateRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Operations::CreateJWTTemplateRequest
  def name(); end
  def name=(str_); end
  def claims(); end
  def claims=(str_); end
  def custom_signing_key(); end
  def custom_signing_key=(str_); end
  def lifetime(); end
  def lifetime=(str_); end
  def allowed_clock_skew(); end
  def allowed_clock_skew=(str_); end
  def signing_algorithm(); end
  def signing_algorithm=(str_); end
  def signing_key(); end
  def signing_key=(str_); end
end