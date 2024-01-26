# frozen_string_literal: true

class Cost < ApplicationRecord
  belongs_to :user

  validates :name, :date, :amount, presence: true
end
