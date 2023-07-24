# frozen_string_literal: true

class Printer < ApplicationRecord
  has_many :printer_maintenance, dependent: :destroy

  enum printing_technology: { fdm: 0, dlp: 1, sla: 2, sls: 3 }
  enum state: { perfect: 0, satisfactory: 1, so_so: 2, sell: 3 }
  enum type_mechanics: { delta: 0, corexy: 1, photopolymer: 2, ulti: 3, driga: 4 }
end
