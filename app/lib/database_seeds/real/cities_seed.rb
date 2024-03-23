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

      def execute_lviv_region_cities
        [
          { english_name: 'Bibrka', ukrainian_name: 'Бібрка' },
          { english_name: 'Boryslav', ukrainian_name: 'Борислав' },
          { english_name: 'Brody', ukrainian_name: 'Броди' },
          { english_name: 'Busk', ukrainian_name: 'Буськ' },
          { english_name: 'Velyki Mosty', ukrainian_name: 'Великі Мости' },
          { english_name: 'Horodok', ukrainian_name: 'Городок' },
          { english_name: 'Drohobych', ukrainian_name: 'Дрогобич' },
          { english_name: 'Dubliany', ukrainian_name: 'Дубляни' },
          { english_name: 'Zhovkva', ukrainian_name: 'Жовква' },
          { english_name: 'Zhydachiv', ukrainian_name: 'Жидачів' },
          { english_name: 'Zolochiv', ukrainian_name: 'Золочів' },
          { english_name: 'Kamianka-Buzka', ukrainian_name: 'Кам\'янка-Бузька' },
          { english_name: 'Lviv', ukrainian_name: 'Львів' },
          { english_name: 'Morshyn', ukrainian_name: 'Моршин' },
          { english_name: 'Mykolaiv', ukrainian_name: 'Миколаїв' },
          { english_name: 'Novyi Rozdil', ukrainian_name: 'Новий Розділ' },
          { english_name: 'Peremyshliany', ukrainian_name: 'Перемишляни' },
          { english_name: 'Pustomyty', ukrainian_name: 'Пустомити' },
          { english_name: 'Radekhiv', ukrainian_name: 'Радехів' },
          { english_name: 'Rava-Ruska', ukrainian_name: 'Рава-Руська' },
          { english_name: 'Sambir', ukrainian_name: 'Самбір' },
          { english_name: 'Skole', ukrainian_name: 'Сколе' },
          { english_name: 'Sokal', ukrainian_name: 'Сокаль' },
          { english_name: 'Sosnivka', ukrainian_name: 'Соснівка' },
          { english_name: 'Staryi Sambir', ukrainian_name: 'Старий Самбір' },
          { english_name: 'Stryi', ukrainian_name: 'Стрий' },
          { english_name: 'Truskavets', ukrainian_name: 'Трускавець' },
          { english_name: 'Uhniv', ukrainian_name: 'Угнів' },
          { english_name: 'Khodoriv', ukrainian_name: 'Ходорів' },
          { english_name: 'Chervonohrad', ukrainian_name: 'Червоноград' },
          { english_name: 'Yavoriv', ukrainian_name: 'Яворів' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_ternopil_region_cities
        [
          { english_name: 'Berezhany', ukrainian_name: 'Бережани' },
          { english_name: 'Buchach', ukrainian_name: 'Бучач' },
          { english_name: 'Zbarazh', ukrainian_name: 'Збараж' },
          { english_name: 'Zalishchyky', ukrainian_name: 'Заліщики' },
          { english_name: 'Kremenets', ukrainian_name: 'Кременець' },
          { english_name: 'Lanivtsi', ukrainian_name: 'Ланівці' },
          { english_name: 'Monastyryska', ukrainian_name: 'Монастириська' },
          { english_name: 'Pidhaitsi', ukrainian_name: 'Підгайці' },
          { english_name: 'Pochaiv', ukrainian_name: 'Почаїв' },
          { english_name: 'Skalat', ukrainian_name: 'Скалат' },
          { english_name: 'Ternopil', ukrainian_name: 'Тернопіль' },
          { english_name: 'Terebovlia', ukrainian_name: 'Теребовля' },
          { english_name: 'Chortkiv', ukrainian_name: 'Чортків' },
          { english_name: 'Shumsk', ukrainian_name: 'Шумськ' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_khmelnytskyi_region_cities
        [
          { english_name: 'Balta', ukrainian_name: 'Балта' },
          { english_name: 'Vinkivtsi', ukrainian_name: 'Віньківці' },
          { english_name: 'Volochysk', ukrainian_name: 'Волочиськ' },
          { english_name: 'Derazhnia', ukrainian_name: 'Деражня' },
          { english_name: 'Dunaivtsi', ukrainian_name: 'Дунаївці' },
          { english_name: 'Izyaslav', ukrainian_name: 'Ізяслав' },
          { english_name: 'Kamianets-Podilskyi', ukrainian_name: 'Кам\'янець-Подільський' },
          { english_name: 'Krasyliv', ukrainian_name: 'Красилів' },
          { english_name: 'Letychiv', ukrainian_name: 'Летичів' },
          { english_name: 'Netishyn', ukrainian_name: 'Нетішин' },
          { english_name: 'Polonne', ukrainian_name: 'Полонне' },
          { english_name: 'Slavuta', ukrainian_name: 'Славута' },
          { english_name: 'Starokostiantyniv', ukrainian_name: 'Старокостянтинів' },
          { english_name: 'Teofipol', ukrainian_name: 'Теофіполь' },
          { english_name: 'Khmelnytskyi', ukrainian_name: 'Хмельницький' },
          { english_name: 'Shepetivka', ukrainian_name: 'Шепетівка' },
          { english_name: 'Yarmolyntsi', ukrainian_name: 'Ярмолинці' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_rivne_region_cities
        [
          { english_name: 'Berestechko', ukrainian_name: 'Берестечко' },
          { english_name: 'Varash', ukrainian_name: 'Варакша' },
          { english_name: 'Volodymyrets', ukrainian_name: 'Володимирець' },
          { english_name: 'Dubno', ukrainian_name: 'Дубно' },
          { english_name: 'Dubrovytsia', ukrainian_name: 'Дубровиця' },
          { english_name: 'Demydivka', ukrainian_name: 'Демидівка' },
          { english_name: 'Dzerzhynsk', ukrainian_name: 'Дзержинськ' },
          { english_name: 'Druzhba', ukrainian_name: 'Дружба' },
          { english_name: 'Zdolbuniv', ukrainian_name: 'Здолбунів' },
          { english_name: 'Korets', ukrainian_name: 'Корець' },
          { english_name: 'Kostopil', ukrainian_name: 'Костопіль' },
          { english_name: 'Kuznetsovsk', ukrainian_name: 'Кузнецовськ' },
          { english_name: 'Mlyniv', ukrainian_name: 'Млинів' },
          { english_name: 'Ostrog', ukrainian_name: 'Острог' },
          { english_name: 'Radyvyliv', ukrainian_name: 'Радивилів' },
          { english_name: 'Rivne', ukrainian_name: 'Рівне' },
          { english_name: 'Sarny', ukrainian_name: 'Сарни' },
          { english_name: 'Sosnivka', ukrainian_name: 'Соснівка' },
          { english_name: 'Turiisk', ukrainian_name: 'Турійськ' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_chernivtsi_region_cities
        [
          { english_name: 'Vyzhnytsia', ukrainian_name: 'Вижниця' },
          { english_name: 'Hertsa', ukrainian_name: 'Герца' },
          { english_name: 'Zastavna', ukrainian_name: 'Заставна' },
          { english_name: 'Chernivtsi', ukrainian_name: 'Чернівці' },
          { english_name: 'Novodnistrovsk', ukrainian_name: 'Новодністровськ' },
          { english_name: 'Sokyriany', ukrainian_name: 'Сокиряни' },
          { english_name: 'Storozhynets', ukrainian_name: 'Сторожинець' },
          { english_name: 'Khotyn', ukrainian_name: 'Хотин' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_zakarpattia_region_cities
        [
          { english_name: 'Berehove', ukrainian_name: 'Берегове' },
          { english_name: 'Vynohradiv', ukrainian_name: 'Виноградів' },
          { english_name: 'Volovets', ukrainian_name: 'Воловець' },
          { english_name: 'Irshava', ukrainian_name: 'Іршава' },
          { english_name: 'Mukachevo', ukrainian_name: 'Мукачево' },
          { english_name: 'Perechyn', ukrainian_name: 'Перечин' },
          { english_name: 'Rakhiv', ukrainian_name: 'Рахів' },
          { english_name: 'Svaliava', ukrainian_name: 'Свалява' },
          { english_name: 'Tiachiv', ukrainian_name: 'Тячів' },
          { english_name: 'Uzhhorod', ukrainian_name: 'Ужгород' },
          { english_name: 'Khust', ukrainian_name: 'Хуст' },
          { english_name: 'Chop', ukrainian_name: 'Чоп' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_volyn_region_cities
        [
          { english_name: 'Kovel', ukrainian_name: 'Ковель' },
          { english_name: 'Lutsk', ukrainian_name: 'Луцьк' },
          { english_name: 'Novovolynsk', ukrainian_name: 'Нововолинськ' },
          { english_name: 'Volodymyr-Volynskyi', ukrainian_name: 'Володимир-Волинський' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_kyiv_region_cities
        [
          { english_name: 'Bila Tserkva', ukrainian_name: 'Біла Церква' },
          { english_name: 'Bohuslav', ukrainian_name: 'Богуслав' },
          { english_name: 'Boryspil', ukrainian_name: 'Бориспіль' },
          { english_name: 'Brovary', ukrainian_name: 'Бровари' },
          { english_name: 'Bucha', ukrainian_name: 'Буча' },
          { english_name: 'Vasylkiv', ukrainian_name: 'Васильків' },
          { english_name: 'Vyshhorod', ukrainian_name: 'Вишгород' },
          { english_name: 'Irpin', ukrainian_name: 'Ірпінь' },
          { english_name: 'Obukhiv', ukrainian_name: 'Обухів' },
          { english_name: 'Pereiaslav-Khmelnytskyi', ukrainian_name: 'Переяслав-Хмельницький' },
          { english_name: 'Rzhyshchiv', ukrainian_name: 'Ржищів' },
          { english_name: 'Slavutych', ukrainian_name: 'Славутич' },
          { english_name: 'Tarascha', ukrainian_name: 'Тараща' },
          { english_name: 'Tetiyiv', ukrainian_name: 'Тетіїв' },
          { english_name: 'Ukrainka', ukrainian_name: 'Українка' },
          { english_name: 'Fastiv', ukrainian_name: 'Фастів' },
          { english_name: 'Yahotyn', ukrainian_name: 'Яготин' },
          { english_name: 'Kyiv', ukrainian_name: 'Київ' }
        ].each do |city|
          City.create!(city) unless does_exist?('City', { english_name: city[:english_name], ukrainian_name: city[:ukrainian_name] })
        end
      end

      def execute_vinnytsia_region_cities
        [
          { english_name: 'Bar', ukrainian_name: 'Бар' },
          { english_name: 'Bershad', ukrainian_name: 'Бершадь' },
          { english_name: 'Vinnytsia', ukrainian_name: 'Вінниця' },
          { english_name: 'Haisyn', ukrainian_name: 'Гайсин' },
          { english_name: 'Hnivan', ukrainian_name: 'Гнівань' },
          { english_name: 'Izmail', ukrainian_name: 'Ізмаїл' },
          { english_name: 'Kalinivka', ukrainian_name: 'Калинівка' },
          { english_name: 'Khmilnyk', ukrainian_name: 'Хмільник' },
          { english_name: 'Kryzhopil', ukrainian_name: 'Крижопіль' },
          { english_name: 'Ladyzhyn', ukrainian_name: 'Ладижин' },
          { english_name: 'Lypovets', ukrainian_name: 'Липовець' },
          { english_name: 'Mohyliv-Podilskyi', ukrainian_name: 'Могилів-Подільський' },
          { english_name: 'Nemyriv', ukrainian_name: 'Немирів' },
          { english_name: 'Orativ', ukrainian_name: 'Оратів' },
          { english_name: 'Pohrebysche', ukrainian_name: 'Погребище' },
          { english_name: 'Tulchyn', ukrainian_name: 'Тульчин' },
          { english_name: 'Teplyk', ukrainian_name: 'Теплик' },
          { english_name: 'Tomashpil', ukrainian_name: 'Томашпіль' },
          { english_name: 'Trostianets', ukrainian_name: 'Тростянець' },
          { english_name: 'Tyvriv', ukrainian_name: 'Тиврів' },
          { english_name: 'Shepetivka', ukrainian_name: 'Шепетівка' },
          { english_name: 'Yampil', ukrainian_name: 'Ямпіль' }
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
