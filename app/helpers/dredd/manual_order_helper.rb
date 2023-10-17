# frozen_string_literal: true

module Dredd
  module ManualOrderHelper
    def app_icon_contact(app_contact)
      case app_contact.to_sym
      when :viber
        'viber_icon'
      when :whatsapp
        'whatsapp_icon'
      when :instagram
        'instagram_icon'
      when :messenger
        'messenger_icon'
      when :telegram
        'telegram_icon'
      else
        'google_icon'
      end
    end

    def workflow_status_icon(workflow_status)
      case workflow_status.to_sym
      when :nothing
        'empty_basket'
      when :modeling
        '3d_modeling_icon'
      when :printing
        '3d_printing_icon'
      when :call_cleint
        'phone_icon'
      else
        'success'
      end
    end
  end
end
