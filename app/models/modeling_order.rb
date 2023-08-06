# frozen_string_literal: true

class ModelingOrder < ApplicationRecord
  has_many_attached :files

  after_create_commit :send_telegram_message

  validates :first_name, :phone_number, presence: true
  validates :phone_number, phone: true
  validates :link_to_model, format: URI::ABS_URI, allow_blank: true
  validates :link_to_model, presence: true, unless: ->(rendering_order) { rendering_order.files.any? }
  validates :files, presence: true, unless: ->(rendering_order) { rendering_order.link_to_model.present? }
  validates :files, content_type: [:pdf, :doc, :docx, :xls, :xlsx, :jpg, :jpeg, :png, :zip, :rar, '7z'], size: { between: (1.kilobyte)..(150.megabytes) }

  enum status: { unpaid: 0, paid: 1 }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def send_telegram_message
    plain_text = 'Hello admins! Someone create Modeling order.
    Check our admin https://3dstorm.com.ua/dredd/modeling_orders page and connect wit a client. ;)'.html_safe

    HTTParty.post("https://api.telegram.org/bot#{TelegramConfig.token}/sendMessage?chat_id=#{TelegramConfig.chat_id}&text=#{plain_text}&reply_to_message_id=4")
  end
end
