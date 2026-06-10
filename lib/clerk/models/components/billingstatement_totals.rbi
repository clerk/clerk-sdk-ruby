# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::BillingStatementTotals
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::BillingStatementTotals
  def grand_total(); end
  def grand_total=(str_); end
  def subtotal(); end
  def subtotal=(str_); end
  def base_fee(); end
  def base_fee=(str_); end
  def tax_total(); end
  def tax_total=(str_); end
end
