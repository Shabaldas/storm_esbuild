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
      when :google
        'google_icon'
      else
        'telegram_icon'
      end
    end

    def order_status_icon(manual_order)
      if manual_order.paid?
        'paid_icon'
      else
        'unpaid_icon'
      end
    end

    def get_selected_printers_names(manual_order)
      JSON.parse(manual_order.printed_on_printers).reject(&:empty?).join(', ')
    end
  end
end
