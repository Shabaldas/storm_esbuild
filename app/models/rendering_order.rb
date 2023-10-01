# frozen_string_literal: true

class RenderingOrder < ApplicationRecord
  has_many_attached :files

  after_create_commit :send_telegram_message

  validates :first_name, :phone_number, presence: true
  validates :phone_number, phone: true
  validates :link_to_model, format: URI::ABS_URI, allow_blank: true
  validates :link_to_model, presence: true, unless: ->(modeling_order) { modeling_order.files.any? }
  validates :files, presence: true, unless: ->(modeling_order) { modeling_order.link_to_model.present? }

  validates :files, content_type: [
    :pdf, :doc, :docx, :xls, :xlsx,
    :jpg, :jpeg, :png, :obj, :stl, :step, :stp, :igs,
    :sldrt, :sldasm, :asm, :prt, :x_t, :x_b, :xmt_txt, :xmt_bin,
    :zip, :rar, '7z'
  ], size: { between: (1.kilobyte)..(150.megabytes) }

  enum status: { unpaid: 0, paid: 1 }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def send_telegram_message
    plain_text = "<b> Hello admins! </b> Someone create Rendering order. \n" \
                 "Check our admin <a href='https://3dstorm.com.ua/dredd/rendering_orders'> Rendering order</a> page and connect wit a client."
    api = ::Telegram::Bot::Api.new(TelegramConfig.token)
    api.call('sendMessage', chat_id: TelegramConfig.chat_id, text: plain_text, reply_to_message_id: 4, parse_mode: 'HTML')
  end
end
