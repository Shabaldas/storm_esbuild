# frozen_string_literal: true

module Entities
  module V1
    class Products < Entity
      present_collection true

      expose :object, proc: proc { 'list' }
      expose :items, as: :data

      expose :url
      expose :has_more

      private

      def url
        '/products'
      end

      def has_more # rubocop:disable Naming/PredicateName
        options[:has_more]
      end
    end
  end
end
