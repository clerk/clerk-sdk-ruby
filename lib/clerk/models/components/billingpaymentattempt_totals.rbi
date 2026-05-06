# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::BillingPaymentAttemptTotals
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::BillingPaymentAttemptTotals
  def subtotal(); end
  def subtotal=(str_); end
  def base_fee(); end
  def base_fee=(str_); end
  def tax_total(); end
  def tax_total=(str_); end
  def grand_total(); end
  def grand_total=(str_); end
  def per_unit_totals(); end
  def per_unit_totals=(str_); end
  def credits(); end
  def credits=(str_); end
end
