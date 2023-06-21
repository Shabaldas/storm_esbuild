# frozen_string_literal: true

class PrintModel < ApplicationRecord
  has_many :print_model_attributes, dependent: :destroy

  has_one_attached :file

  accepts_nested_attributes_for :print_model_attributes, allow_destroy: true
end
