describe PrintingHelper do
  describe '#material_for_select' do
    delegate :material_for_select, to: :helper

    it 'returns option values for select' do
      expect(material_for_select).to eq(
        [
          ['Пластик PLA (від ₴/г)', 'PLA', { data: {
            '100'=> {
              price_per_one: 100,
              price_per_fifth: 75,
              price_per_hundredth: 55,
              price_per_hundred_and_fifty: 15
            },
            '200'=> {
              price_per_one: 150,
              price_per_fifth: 125,
              price_per_hundredth: 105,
              price_per_hundred_and_fifty: 65
            },
            '300'=> {
              price_per_one: 200,
              price_per_fifth: 175,
              price_per_hundredth: 155,
              price_per_hundred_and_fifty: 115
            }
          } }],
          ['Пластик ABS (від ₴/г)', 'ABS', { data: {
            '100'=> {
              price_per_one: 200,
              price_per_fifth: 175,
              price_per_hundredth: 155,
              price_per_hundred_and_fifty: 115
            },
            '200'=> {
              price_per_one: 250,
              price_per_fifth: 225,
              price_per_hundredth: 205,
              price_per_hundred_and_fifty: 165
            },
            '300'=> {
              price_per_one: 300,
              price_per_fifth: 275,
              price_per_hundredth: 255,
              price_per_hundred_and_fifty: 215
            }
          } }]


         
        ]
      )
    end

   
  end
end
