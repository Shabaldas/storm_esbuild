# frozen_string_literal: true

module PrintingHelper
  MATERIALS = {
    'PLA' => {
      100 => {
        price_per_one: 100,
        price_per_fifth: 75,
        price_per_hundredth: 55,
        price_per_hundred_and_fifty: 15
      },
      200 => {
        price_per_one: 150,
        price_per_fifth: 125,
        price_per_hundredth: 105,
        price_per_hundred_and_fifty: 65
      },
      300 => {
        price_per_one: 200,
        price_per_fifth: 175,
        price_per_hundredth: 155,
        price_per_hundred_and_fifty: 115
      }
    },
    'ABS' => {
      100 => {
        price_per_one: 200,
        price_per_fifth: 175,
        price_per_hundredth: 155,
        price_per_hundred_and_fifty: 115
      },
      200 => {
        price_per_one: 250,
        price_per_fifth: 225,
        price_per_hundredth: 205,
        price_per_hundred_and_fifty: 165
      },
      300 => {
        price_per_one: 300,
        price_per_fifth: 275,
        price_per_hundredth: 255,
        price_per_hundred_and_fifty: 215
      }
    },
  }.freeze

  def material_for_select
    MATERIALS.map do |material, value|
      # binding.pry
      [
        "Пластик #{material} (від #{value[:price_per_one]}₴/г)",
        material,
        {
          data: {
            '100'=> {
              price_per_one: value[100][:price_per_one],
              price_per_fifth: value[100][:price_per_fifth],
              price_per_hundredth: value[100][:price_per_hundredth],
              price_per_hundred_and_fifty: value[100][:price_per_hundred_and_fifty]
            },
            '200'=> {
              price_per_one: value[200][:price_per_one],
              price_per_fifth: value[200][:price_per_fifth],
              price_per_hundredth: value[200][:price_per_hundredth],
              price_per_hundred_and_fifty: value[200][:price_per_hundred_and_fifty]
            },
            '300'=> {
              price_per_one: value[300][:price_per_one],
              price_per_fifth: value[300][:price_per_fifth],
              price_per_hundredth: value[300][:price_per_hundredth],
              price_per_hundred_and_fifty: value[300][:price_per_hundred_and_fifty]
            }
          }
        }
      ]
    end
  end
end
