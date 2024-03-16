RSpec.describe DatabaseSeeds::Dummy::ManualOrdersSeed do
  describe '#execute' do
    let(:client) { create(:client) }

    before do
      allow(Client).to receive(:all).and_return([client])
      allow(FactoryBot).to receive(:create)
    end

    # rubocop:disable RSpec/MessageSpies
    it 'creates manual orders for each client' do
      expect(FactoryBot).to receive(:create).exactly(5).times.with(
        :manual_order,
        first_name: client.first_name,
        last_name: client.last_name,
        email: client.email,
        phone_number: client.phone_number,
        client_id: client.id
      )

      described_class.new.execute
    end
    # rubocop:enable RSpec/MessageSpies
  end
end
