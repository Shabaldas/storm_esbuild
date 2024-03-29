# frozen_string_literal: true

module ProductHelper
  def size_option_value_for_select
    OptionValue.where(option: Option.find_by(measurement: 'mm')).map { |option_value| [option_value.value, option_value.id] }
  end

  def size_value_for_select(product)
    product.size_and_price.map { |option| [option[:value], option[:id], { data: { price: option[:price].to_f } }] }
  end

  def static_first_price(product)
    size_value_for_select(product).first.last.dig(:data, :price).round
  end

  def products_count_for_parent_category(parent_category)
    parent_category.children.sum { |category| category.products.count }
  end

  def select_colors
    {
      white: '#FFFFFF',
      black: '#000000',
      gray: '#808080',
      green: '#008000',
      red: '#FF0000',
      yellow: '#FFEA00',
      blue: '#0000FF'
    }
  end
end
