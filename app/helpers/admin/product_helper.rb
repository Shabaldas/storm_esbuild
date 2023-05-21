# frozen_string_literal: true

module Admin
  module ProductHelper
    def product_categories_for_select
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
  end
end
