RSpec.describe DatabaseSeeds::Dummy::ClientsSeed do
  describe '#execute' do
    context 'when executing seed' do
      before { described_class.new.execute }

      it 'creates 25 clients' do
        expect(Client.count).to eq(25)
      end
    end
  end
end
