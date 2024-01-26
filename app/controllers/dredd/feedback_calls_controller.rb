# frozen_string_literal: true

module Dredd
  class FeedbackCallsController < BaseController
    def index
      @pagy, @feedback_calls = pagy(FeedbackCall.order(created_at: :desc), items: 20)
    end

    def update
      feedback_call = FeedbackCall.find(params[:id])
      feedback_call.toggle!(:processed) # rubocop:disable Rails/SkipsModelValidations

      redirect_to dredd_feedback_calls_path, notice: { text: 'Feedback call was successfully updated.', icon: 'success_icon' }
    end

    def destroy
      feedback_call = FeedbackCall.find(params[:id])
      feedback_call.destroy!

      redirect_to dredd_feedback_calls_path, error: { text: 'Feedback call was successfully destroyed.', icon: 'attention' }
    end
  end
end
