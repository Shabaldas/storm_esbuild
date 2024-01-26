# frozen_string_literal: true

module Dredd
  module AccountingHelper
    def profit(earning, costs, rewards)
      earning.to_f - costs.to_f - rewards.to_f
    end
  end
end
