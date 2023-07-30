# frozen_string_literal: true

class ModelingOrder < ApplicationRecord
  validates :first_name, :phone_number, presence: true
  validates :phone_number, phone: true
  validates :link_to_model, format: URI::ABS_URI, allow_blank: true

  has_many_attached :files

  enum status: { unpaid: 0, paid: 1 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
