# frozen_string_literal: true

class ManualOrderLineItem < ApplicationRecord
  belongs_to :manual_order_invoice
end
