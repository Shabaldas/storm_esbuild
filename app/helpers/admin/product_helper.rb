# frozen_string_literal: true

module Admin
  module ProductHelper
    def product_categories_for_product_select
      ProductCategory.only_children.map { |product_category| [product_category.name, product_category.id] }
    end

    def product_categories_for_categories_select
      ProductCategory.all.map { |product_category| [product_category.name, product_category.id] }
    end

    def classes_for_flash(flash_type)
      case flash_type.to_sym
      when :error
        'bg-danger'
      else
        'bg-primary'
      end
    end

    def color_option_value_for_select
      OptionValue.where(option: Option.find_by(measurement: 'color')).map { |option_value| [option_value.value, option_value.id] }
    end

    def size_option_value_for_select
      OptionValue.where(option: Option.find_by(measurement: 'mm')).map { |option_value| [option_value.value, option_value.id] }
    end
  end
end
