RSpec.describe DatabaseSeeds::Main do
  describe '#execute' do
    it 'calls the ProductCategoriesSeed' do
      expect_any_instance_of(DatabaseSeeds::Dummy::ProductCategoriesSeed).to receive(:execute)
      described_class.new.execute
    end
  end
end
