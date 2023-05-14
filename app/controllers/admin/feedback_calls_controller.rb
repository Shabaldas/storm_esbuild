# frozen_string_literal: true

module Admin
  class FeedbackCallsController < BaseController
    def index
      @pagy, @feedback_calls = pagy(FeedbackCall.all, items: 10)
    end
  end
end
