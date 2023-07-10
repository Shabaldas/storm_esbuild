# frozen_string_literal: true

class FeedbackCall < ApplicationRecord
  validates :phone_number, presence: true, phone: true
end
