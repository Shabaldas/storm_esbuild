RSpec.describe DatabaseSeeds::Real::CitiesSeed do
  describe '#execute_frankivsk_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_frankivsk_region_cities }

      it 'creates unique cities in frankivsk region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(18)
      end
    end
  end

  describe '#execute_lviv_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_lviv_region_cities }

      it 'creates unique cities in lviv region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(31)
      end
    end
  end

  describe '#execute_ternopil_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_ternopil_region_cities }

      it 'creates unique cities in ternopil region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(14)
      end
    end
  end

  describe '#execute_chernivtsi_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_chernivtsi_region_cities }

      it 'creates unique cities in chernivtsi region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(8)
      end
    end
  end

  describe '#execute_rivne_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_rivne_region_cities }

      it 'creates unique cities in rivne region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(19)
      end
    end
  end

  describe '#execute_volyn_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_volyn_region_cities }

      it 'creates unique cities in volyn region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(4)
      end
    end
  end

  describe '#execute_zakarpattia_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_zakarpattia_region_cities }

      it 'creates unique cities in zakarpattia region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(12)
      end
    end
  end

  describe '#execute_khmelnytskyi_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_khmelnytskyi_region_cities }

      it 'creates unique cities in khmelnytskyi region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(17)
      end
    end
  end

  describe '#execute_vinnytsia_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_vinnytsia_region_cities }

      it 'creates unique cities in vinnytsia region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(22)
      end
    end
  end

  describe '#execute_kyiv_region_cities' do
    context 'when executing seed' do
      before { described_class.new.execute_kyiv_region_cities }

      it 'creates unique cities in kyiv region' do
        city_ids = City.all.pluck(:id)
        expect(city_ids.size).to eq(city_ids.uniq.size)
        expect(city_ids.count).to eq(18)
      end
    end
  end
end
