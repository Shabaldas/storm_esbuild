# frozen_string_literal: true

module ApplicationHelper
  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
      result << [('- ' * item.depth) + item.name, item.id]
      result += nested_dropdown(sub_items) if sub_items.present?
    end
    result
  end
end
