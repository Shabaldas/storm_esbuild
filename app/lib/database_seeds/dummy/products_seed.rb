# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ProductsSeed
      def execute
        ProductCategory.all.each do |category|
          times = category.has_parent? ? 10 : 5

          times.times do |product_id|
            next if does_exist?((category.id.to_s + product_id.to_s).to_i)

            category.products.create(
              id: (category.id.to_s + product_id.to_s).to_i,
              name: Faker::Commerce.product_name,
              description: Faker::Company.catch_phrase,
              price: Faker::Commerce.price(range: 40..100.0),
              status: 'active'
            )
          end
        end
      end

      private

      def does_exist?(id)
        Product.exists?(id: id)
      end
    end
  end
end
