# frozen_string_literal: true

module Dredd
  module ManualOrderHelper
    def app_icon_contact(app_contact)
      case app_contact.to_sym
      when :telegram
        'telegram_icon'
      when :viber
        'viber_icon'
      when :whatsapp
        'whatsapp_icon'
      when :instagram
        'instagram_icon'
      when :messenger
        'messenger_icon'
      when :google
        'google_icon'
      else
        'phone_icon'
      end
    end

    def order_status_icon(manual_order)
      if manual_order.paid?
        'paid_icon'
      else
        'unpaid_icon'
      end
    end
  end
end
