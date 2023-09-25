# frozen_string_literal: true

class FeedbackCall < ApplicationRecord
  validates :phone_number, presence: true, phone: true

  after_create_commit :send_telegram_message

  private

  def send_telegram_message
    plain_text = "<b> Hello admins! </b> \n Someone left a mobile phone number for feedback on our website. \n" \
                 "Actually, here it is: <b>#{phone_number}</b> Please call as soon as you can, and don't forget to delete this number from the database."
    api = ::Telegram::Bot::Api.new(TelegramConfig.token)
    api.call('sendMessage', chat_id: TelegramConfig.chat_id, text: plain_text, reply_to_message_id: 12, parse_mode: 'HTML')
  end
end
