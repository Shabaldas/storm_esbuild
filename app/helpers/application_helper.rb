# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  COLORS = ['FFFFFF', 'E9646B', 'F1C232', '202020', '96E06C', '67ACEC'].freeze
  MATERIALS = ['PLA', 'ABS', 'PET', 'Nylon', 'Elastan'].freeze
  QUALITY = [100, 200, 300].freeze
end
