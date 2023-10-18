# frozen_string_literal: true

class ManualOrder < ApplicationRecord
  PRINTING_COLORS = [
    'Black', 'White', 'Grey', 'Transparent', 'Blue,', 'Yellow', 'Violet', 'Natural', 'Orange'
  ].freeze

  # associations
  belongs_to :worker, optional: true

  # callbacks
  before_create :set_print_code
  before_update :update_end_date

  # enums
  enum app_contact: { google: 0, viber: 1, whatsapp: 2, instagram: 3, messenger: 4, telegram: 5 }
  enum status: { unpaid: 0, paid: 1 }
  enum workflow_status: { nothing: 0, modeling: 1, printing: 2, called_cleint: 3, done: 4 }

  # validations
  validates :first_name, :total_price, presence: true
  validates :phone_number, phone: true, allow_blank: true

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def update_end_date
    self.end_date = Time.zone.now if paid? && status_changed?
  end

  def set_print_code
    last_order = ManualOrder.order('id DESC').first
    last_index = last_order ? last_order.print_code.split('-').last.to_i : 100_000
    self.print_code = "01-#{last_index + 1}"
  end
end
