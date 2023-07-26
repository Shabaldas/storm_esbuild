# frozen_string_literal: true

module PrintingHelper
  FDM_MATERIALS = {
    'ABS+, PLA, PET, coPET' => {
      '100' => {
        price_per_fifth: 8.0,
        price_per_hundredth: 7.5,
        price_per_hundred_and_fifty: 7.0
      },
      '200' => {
        price_per_fifth: 7.0,
        price_per_hundredth: 6.5,
        price_per_hundred_and_fifty: 6.0
      },
      '300' => {
        price_per_fifth: 6.5,
        price_per_hundredth: 5.5,
        price_per_hundred_and_fifty: 5.0
      }
    },
    'ELASTAN,TPU, Nylon, PC' => {
      '100' => {
        price_per_fifth: 16.0,
        price_per_hundredth: 14.0,
        price_per_hundred_and_fifty: 11.0
      },
      '200' => {
        price_per_fifth: 14.0,
        price_per_hundredth: 12.0,
        price_per_hundred_and_fifty: 10.0
      },
      '300' => {
        price_per_fifth: 12.0,
        price_per_hundredth: 10.0,
        price_per_hundred_and_fifty: 8.0
      }
    }
  }.freeze

  def sla_materials
    {
      'SLA ENGENIRING' => {
        '35' => {
          price_per_fifth: 8.0,
          price_per_hundredth: 7.5,
          price_per_hundred_and_fifty: 7.0
        },
        '50' => {
          price_per_fifth: 7.0,
          price_per_hundredth: 6.5,
          price_per_hundred_and_fifty: 6.0
        },
        '300' => {
          price_per_fifth: 6.5,
          price_per_hundredth: 5.5,
          price_per_hundred_and_fifty: 5.0
        }
      }
    }.freeze
  end

  def dlp_materials
    {
      'DLP MODEL PHOTOPOLYMER RESIN' => {
        '35' => {
          price_per_fifth: 8.0,
          price_per_hundredth: 7.5,
          price_per_hundred_and_fifty: 7.0
        },
        '50' => {
          price_per_fifth: 7.0,
          price_per_hundredth: 6.5,
          price_per_hundred_and_fifty: 6.0
        },
        '300' => {
          price_per_fifth: 6.5,
          price_per_hundredth: 5.5,
          price_per_hundred_and_fifty: 5.0
        }
      }
    }.freeze
  end

  def fdm_materials_price_for_table(params_material)
    FDM_MATERIALS[params_material]
  end

  def fdm_material_for_select
    FDM_MATERIALS.map do |material, _value|
      [
        "#{t('static_pages.printing.plastics')} #{material}",
        printing_path(material:)
      ]
    end
  end

  def sla_material_for_select
    FDM_MATERIALS.map do |material, _value|
      [
        "#{t('static_pages.printing.plastics')} #{material}",
        printing_path(material:)
      ]
    end
  end
end
