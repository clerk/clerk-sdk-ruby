# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::JWTTemplate
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::JWTTemplate
  def object(); end
  def object=(str_); end
  def id(); end
  def id=(str_); end
  def name(); end
  def name=(str_); end
  def claims(); end
  def claims=(str_); end
  def lifetime(); end
  def lifetime=(str_); end
  def allowed_clock_skew(); end
  def allowed_clock_skew=(str_); end
  def custom_signing_key(); end
  def custom_signing_key=(str_); end
  def signing_algorithm(); end
  def signing_algorithm=(str_); end
  def created_at(); end
  def created_at=(str_); end
  def updated_at(); end
  def updated_at=(str_); end
end