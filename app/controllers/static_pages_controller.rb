# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @feedback_call = FeedbackCall.new
  end

  def save_phone_number
    @feedback_call = FeedbackCall.new(feedback_call_params)

    if @feedback_call.save
      redirect_to root_path
    else
      render :home, status: :unprocessable_entity
    end
  end

  private

  def feedback_call_params
    params.require(:feedback_call).permit(:phone_number)
  end
end
