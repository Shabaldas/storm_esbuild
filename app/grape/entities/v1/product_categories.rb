# frozen_string_literal: true

module Entities
  module V1
    class ProductCategories < Entity
      present_collection true

      expose :object, proc: proc { 'list' }
      expose :items, as: :data
    end
  end
end
