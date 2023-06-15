# frozen_string_literal: true

module ProductHelper
  def size_option_value_for_select
    OptionValue.where(option: Option.find_by(measurement: 'mm')).map { |option_value| [option_value.value, option_value.id] }
  end

  def size_value_for_select(product)
    product.size_and_price.map { |option| [option[:value], option[:id], { data: { price: option[:price] } }] }
  end
end
