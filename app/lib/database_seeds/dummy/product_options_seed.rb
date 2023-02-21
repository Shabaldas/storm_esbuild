# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ProductOptionsSeed
      def execute
        # Existing Options
        size_option = Option.find_by(id: 1, title: 'Size', measurement: :mm)
        color_option = Option.find_by(id: 2, title: 'Color', measurement: :color)

        # Product_for_parent_category
        Product.first(8).each do |product|
          # seed only colors option
          color_option.option_values.pluck(:value).each do |option_value|
            product.product_options.find_or_create_by(option: color_option, primary: true).product_option_values.find_or_create_by!(
              option_value: color_option.option_values.find_by(value: option_value)
            )
          end
        end

        Product.where(id: 23..40).each do |product|
          # seed only size option
          size_option.option_values.pluck(:value).each.with_index(1) do |option_value, index|
            product.product_options.find_or_create_by(option: size_option).product_option_values.find_or_create_by!(
              option_value: size_option.option_values.find_by(value: option_value),
              price: 10.0 * index
            )
          end
        end

        Product.where(id: 41..54).each do |product|
          # seed colors&size options
          color_option.option_values.pluck(:value).each do |option_value|
            product.product_options.find_or_create_by(option: color_option, primary: true).product_option_values.find_or_create_by!(
              option_value: color_option.option_values.find_by(value: option_value)
            )
          end

          size_option.option_values.pluck(:value).each.with_index(1) do |option_value, index|
            product.product_options.find_or_create_by(option: size_option).product_option_values.find_or_create_by!(
              option_value: size_option.option_values.find_by(value: option_value),
              price: 10.0 * index
            )
          end
        end

        # Product_for_child_category
        Product.last(50).each do |product|
          # seed colors&size options
          color_option.option_values.pluck(:value).each do |option_value|
            product.product_options.find_or_create_by(option: color_option, primary: true).product_option_values.find_or_create_by!(
              option_value: color_option.option_values.find_by(value: option_value)
            )
          end

          size_option.option_values.pluck(:value).each.with_index(1) do |option_value, index|
            product.product_options.find_or_create_by(option: size_option).product_option_values.find_or_create_by!(
              option_value: size_option.option_values.find_by(value: option_value),
              price: 10.0 * index
            )
          end
        end
      end
    end
  end
end
