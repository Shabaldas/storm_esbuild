# frozen_string_literal: true

class ModelingOrder < ApplicationRecord
  has_many_attached :files

  validates :first_name, :phone_number, presence: true
  validates :phone_number, phone: true
  validates :link_to_model, format: URI::ABS_URI, allow_blank: true
  validates :link_to_model, presence: true, unless: ->(rendering_order) { rendering_order.files.any? }
  validates :files, presence: true, unless: ->(rendering_order) { rendering_order.link_to_model.present? }
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
end
