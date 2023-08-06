# frozen_string_literal: true

module Dredd
  module FeedbackCallHelper
    def proccessed_icon(feedback_call)
      if feedback_call.processed?
        'done_icon'
      else
        'not_done_icon'
      end
    end
  end
end
