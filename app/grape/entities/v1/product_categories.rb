# frozen_string_literal: true

module Entities
  module V1
    class ProductCategories < Entity
      present_collection true

      expose :object, proc: proc { 'list' }
      expose :items, as: :data

      expose :url
      expose :has_more

      private

      def url
        '/product_categories'
      end

      def has_more # rubocop:disable Naming/PredicateName
        options[:has_more]
      end
    end
  end
end
