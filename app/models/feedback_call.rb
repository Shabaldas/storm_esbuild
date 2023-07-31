# frozen_string_literal: true

class FeedbackCall < ApplicationRecord
  validates :phone_number, presence: true, phone: true

  after_create_commit :send_telegram_message

  private

  def send_telegram_message
    plain_text = "Hello admins! Someone left a mobile phone number for feedback on our website.
    Actually, here it is: #{phone_number}. Please call as soon as you can, and don't forget to delete this number from the database ;)".html_safe

    HTTParty.post("https://api.telegram.org/bot#{TelegramConfig.token}/sendMessage?chat_id=#{TelegramConfig.chat_id}&text=#{plain_text}&reply_to_message_id=12")
  end
end
