RSpec.describe DatabaseSeeds::Dummy::WorkersSeed do
  describe '#execute' do
    context 'when executing seed' do
      before { described_class.new.execute }

      it 'creates 5 workers' do
        expect(Worker.count).to eq(5)
      end
    end
  end
end
