# frozen_string_literal: true

module Dredd
  module PrinterHelper
    def select_value(input)
      if input.present?
        input.to_s.camelize
      else
        t('dredd.manual_orders.select')
      end
    end
  end
end
