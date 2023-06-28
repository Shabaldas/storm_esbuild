# frozen_string_literal: true

class Order < ApplicationRecord
  has_one :cart, dependent: :destroy

  enum status: { unpaid: 0, paid: 1 }
end
