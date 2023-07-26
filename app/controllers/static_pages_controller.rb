# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :authorize_admin, only: :printing

  def home
    @feedback_call = FeedbackCall.new
  end

  def save_phone_number
    @feedback_call = FeedbackCall.create(feedback_call_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def printing; end

  private

  def feedback_call_params
    params.require(:feedback_call).permit(:phone_number)
  end

  def authorize_admin
    authorize :admin, :access?
  end
end
