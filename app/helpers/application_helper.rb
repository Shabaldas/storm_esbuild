# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  COLORS = ['FFFFFF', 'E9646B', 'F1C232', '202020', '96E06C', '67ACEC', '5e36a2'].freeze
  MATERIALS = ['PLA', 'ABS', 'PET', 'Nylon', 'Elastan'].freeze
  QUALITY = [100, 200, 300].freeze
  PRINTING_TECHNOLOGY = ['Fdm', 'Dlp', 'Sla', 'Sls'].freeze
  STATE = ['Perfect', 'Satisfactory', 'So_so', 'Sell'].freeze
  TYPE_MECHANIC = ['Delta', 'Corexy', 'Photopolymer', 'Ulti', 'Driga'].freeze

  def current_locale?(locale)
    I18n.locale == locale
  end

  def current_locale_icon(locale)
    case locale
    when :en
      'ukraine'
    when :uk
      'england'
    end
  end
end
