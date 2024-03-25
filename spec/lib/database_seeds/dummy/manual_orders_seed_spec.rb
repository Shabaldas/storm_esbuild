RSpec.describe DatabaseSeeds::Dummy::ManualOrdersSeed do
  describe '#execute' do
    let(:client) { create(:client) }

    before { described_class.new.execute }

    it 'creates 25 manual orders' do
      expect(ManualOrder.count).to eq(25)
    end
  end
end
