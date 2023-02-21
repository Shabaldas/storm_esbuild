# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class OptionsSeed
      def execute
        # Seed Options
        size_option = Option.find_or_create_by(id: 1, title: 'Size', measurement: :mm)
        color_option = Option.find_or_create_by(id: 2, title: 'Color', measurement: :color)

        # Seed OptionValues
        ['White', 'Black', 'Green', 'Red', 'Blue', 'Yellow', 'Gray'].each do |color|
          color_option.option_values.create(value: color) unless does_exist?('OptionValue', { value: color })
        end

        ['S', 'L', 'M', 'XS', 'XL'].each do |size|
          size_option.option_values.create(value: size) unless does_exist?('OptionValue', { value: size })
        end
      end

      private

      def does_exist?(class_name, params = {})
        class_name.constantize.exists?(params)
      end
    end
  end
end
