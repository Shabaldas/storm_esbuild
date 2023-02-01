# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ProductCategoriesSeed
      def execute
        (1..5).to_a.each do |id|
          next if does_exist?(id)

          ProductCategory.create(
            id: id,
            name: Faker::Company.name,
            description: Faker::Company.catch_phrase
          )
        end

        ProductCategory.limit(5).each do |category|
          (1..(2..6).to_a.sample).each do
            category.children.create(
              name: Faker::Company.name,
              description: Faker::Company.catch_phrase
            )
          end
        end
      end

      private

      def does_exist?(id)
        ProductCategory.exists?(id: id)
      end
    end
  end
end
