# frozen_string_literal: true

class ManualOrderInvoice < ApplicationRecord
  belongs_to :manual_order
  has_many :manual_order_line_items, dependent: :destroy
  accepts_nested_attributes_for :manual_order_line_items, allow_destroy: true

  validates :subtotal, :taxes, :discounts, :grand_total, numericality: { greater_than_or_equal_to: 0 }

  before_create :set_invoice_number

  private

  def set_invoice_number
    self.invoice_number = manual_order.print_code
  end
end
