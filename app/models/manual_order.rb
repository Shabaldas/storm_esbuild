# frozen_string_literal: true

class ManualOrder < ApplicationRecord
  OUR_PRINTERS = [
    'Ender-3Pro', 'Guider', 'Custom'
  ].freeze

  PRINTING_COLORS = [
    'Black', 'White', 'Transparent', 'Natural', 'Orange'
  ].freeze

  before_create :set_print_code

  enum app_contact: { telegram: 0, viber: 1, whatsapp: 2, instagram: 3, messenger: 4, google: 5 }
  enum status: { unpaid: 0, paid: 1 }

  validates :first_name, :total_price, presence: true
  validates :phone_number, presence: true, phone: true

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_print_code
    last_order = ManualOrder.order('id DESC').first
    last_index = last_order ? last_order.print_code.split('-').last.to_i : 100_000
    self.print_code = "01-#{last_index + 1}"
  end
end
