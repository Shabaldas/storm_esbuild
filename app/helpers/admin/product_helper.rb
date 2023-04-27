# frozen_string_literal: true

module Admin
  module ProductHelper
    def product_categories_for_select
      ProductCategory.all.map { |product_category| [product_category.name, product_category.id] }
    end
  end
end
