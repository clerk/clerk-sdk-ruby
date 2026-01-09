# typed: false
# frozen_string_literal: true


class Clerk::Models::Components::Totals
  extend ::Crystalline::MetadataFields::ClassMethods
end


class Clerk::Models::Components::Totals
  def grand_total(); end
  def grand_total=(str_); end
  def subtotal(); end
  def subtotal=(str_); end
  def tax_total(); end
  def tax_total=(str_); end
end