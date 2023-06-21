# frozen_string_literal: true

class PrintModelAttribute < ApplicationRecord
  has_one :cart_item, as: :cartable, dependent: :destroy

  belongs_to :print_model

  delegate :name, to: :print_model
end
