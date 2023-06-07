# frozen_string_literal: true

module ProductHelper
  def size_option_value_for_select
    OptionValue.where(option: Option.find_by(measurement: 'mm')).map { |option_value| [option_value.value, option_value.id] }
  end
end
