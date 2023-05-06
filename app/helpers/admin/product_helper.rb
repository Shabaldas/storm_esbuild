# frozen_string_literal: true

module Admin
  module ProductHelper
    def product_categories_for_select
      ProductCategory.all.map { |product_category| [product_category.name, product_category.id] }
    end

    def color_option_value_for_select
      Option.color.last.option_values.all.map { |option_value| [option_value.value, option_value.id] }
    end
  end
end
