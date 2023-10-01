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
  end
end
