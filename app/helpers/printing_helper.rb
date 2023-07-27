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
    'TPU, ELASTAN: D70, D100, D160' => {
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
    },
    'Nylon, PC' => {
      '100' => {
        price_per_fifth: 12.0,
        price_per_hundredth: 10.0,
        price_per_hundred_and_fifty: 8.0
      },
      '200' => {
        price_per_fifth: 11.0,
        price_per_hundredth: 9.0,
        price_per_hundred_and_fifty: 7.5
      },
      '300' => {
        price_per_fifth: 10.0,
        price_per_hundredth: 8.0,
        price_per_hundred_and_fifty: 7.0
      }
    }
  }.freeze

  SLA_MATERIALS =
    {
      'Modeling Resin, Flexible 80A, Clear' =>
      {
        '25' => {
          price_per_fifth: 40.0,
          price_per_hundredth: 35.0,
          price_per_hundred_and_fifty: 30.0
        },
        '35' => {
          price_per_fifth: 35.0,
          price_per_hundredth: 33.0,
          price_per_hundred_and_fifty: 28.0
        },
        '50' => {
          price_per_fifth: 30.0,
          price_per_hundredth: 28.0,
          price_per_hundred_and_fifty: 25.0
        }
      },
      'High precision photopolymer Resin' =>
      {
        '25' => {
          price_per_fifth: 50.0,
          price_per_hundredth: 45.0,
          price_per_hundred_and_fifty: 40.0
        },
        '35' => {
          price_per_fifth: 45.0,
          price_per_hundredth: 42.0,
          price_per_hundred_and_fifty: 39.0
        },
        '50' => {
          price_per_fifth: 38.0,
          price_per_hundredth: 36.0,
          price_per_hundred_and_fifty: 35.0
        }
      }
    }.freeze

  DLP_MATERIALS =
    {
      'Modeling Resin' =>
      {
        '25' => {
          price_per_fifth: 18.0,
          price_per_hundredth: 16.0,
          price_per_hundred_and_fifty: 15.0
        },
        '35' => {
          price_per_fifth: 15.0,
          price_per_hundredth: 14.0,
          price_per_hundred_and_fifty: 13.0
        },
        '50' => {
          price_per_fifth: 14.0,
          price_per_hundredth: 13.0,
          price_per_hundred_and_fifty: 12.0
        }
      },
      'Engineering Resin' =>
      {
        '25' => {
          price_per_fifth: 35.0,
          price_per_hundredth: 33.0,
          price_per_hundred_and_fifty: 30.0
        },
        '35' => {
          price_per_fifth: 33.0,
          price_per_hundredth: 30.0,
          price_per_hundred_and_fifty: 29.0
        },
        '50' => {
          price_per_fifth: 30.0,
          price_per_hundredth: 29.0,
          price_per_hundred_and_fifty: 27.0
        }
      }
    }.freeze

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

  def sla_materials_price_for_table(params_material)
    SLA_MATERIALS[params_material]
  end

  def sla_material_for_select
    SLA_MATERIALS.map do |material, _value|
      [
        "#{t('static_pages.printing.resins')} #{material}",
        printing_path(material:)
      ]
    end
  end

  def dlp_materials_price_for_table(params_material)
    DLP_MATERIALS[params_material]
  end

  def dlp_material_for_select
    DLP_MATERIALS.map do |material, _value|
      [
        "#{t('static_pages.printing.resins')} #{material}",
        printing_path(material:)
      ]
    end
  end
end
