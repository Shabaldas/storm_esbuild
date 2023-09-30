# frozen_string_literal: true

class Cost < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :amount, presence: true
end
