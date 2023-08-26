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
end
