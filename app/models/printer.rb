# frozen_string_literal: true

class Printer < ApplicationRecord
  has_many :printer_maintenance, dependent: :destroy

  accepts_nested_attributes_for :printer_maintenance, reject_if: :all_blank, allow_destroy: true

  enum printing_technology: { fdm: 0, dlp: 1, sla: 2, sls: 3 }
  enum state: { perfect: 0, satisfactory: 1, so_so: 2, sell: 3 }
  enum type_mechanic: { delta: 0, corexy: 1, photopolymer: 2, ulti: 3, driga: 4 }

  validates :printer_code, :table_size, presence: true
end
