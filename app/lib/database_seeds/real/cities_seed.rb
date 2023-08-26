# frozen_string_literal: true

module DatabaseSeeds
  module Real
    class CitiesSeed
      def execute_frankivsk_region_cities
        [
          { english_name: 'Bohorodchany', ukrainian_name: 'Богородчани' },
          { english_name: 'Bolekhiv', ukrainian_name: 'Болехів' },
          { english_name: 'Burshtyn', ukrainian_name: 'Бурштин' },
          { english_name: 'Verkhovyna', ukrainian_name: 'Верховина' },
          { english_name: 'Halych', ukrainian_name: 'Галич' },
          { english_name: 'Horodenka', ukrainian_name: 'Городенка' },
          { english_name: 'Dolyna', ukrainian_name: 'Долина' },
          { english_name: 'Kalush', ukrainian_name: 'Калуш' },
          { english_name: 'Kolomyia', ukrainian_name: 'Коломия' },
          { english_name: 'Ivano-Frankivsk', ukrainian_name: 'Івано-Франківськ' },
          { english_name: 'Kosiv', ukrainian_name: 'Косів' },
          { english_name: 'Nadvirna', ukrainian_name: 'Надвірна' },
          { english_name: 'Rohatyn', ukrainian_name: 'Рогатин' },
          { english_name: 'Rozhniativ', ukrainian_name: 'Рожнятів' },
          { english_name: 'Sniatyn', ukrainian_name: 'Снятин' },
          { english_name: 'Tysmenytsia', ukrainian_name: 'Тисмениця' },
          { english_name: 'Tlumach', ukrainian_name: 'Тлумач' },
          { english_name: 'Yaremche', ukrainian_name: 'Яремче' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      private

      def does_exist?(class_name, params = {})
        class_name.constantize.exists?(params)
      end
    end
  end
end
