# rubocop:disable RSpec/DescribeClass, RSpec/LetSetup
Rails.application.load_tasks

RSpec.describe 'client_find_or_create Rake Task' do
  describe 'create new client' do
    let(:worker) { create(:worker) }
    let!(:manual_order) { create(:manual_order, worker_id: worker.id) }
    let!(:manual_orders) { create_list(:manual_order, 5, worker_id: worker.id) }

    it 'creates clients from manual orders' do
      Rake::Task['client_find_or_create:manual_order'].invoke

      expect(Client.count).to eq(6)
      expect(manual_order.reload.client_id).to eq(Client.first.id)
      expect(manual_order.reload.worker_id).to eq(Worker.first.id)
      expect(manual_orders[-1].reload.worker_id).to eq(Worker.first.id)
    end
  end

  describe 'client whas exist' do
    context 'when not create new client when in data from Manual is exist in client' do
      let!(:worker) { create(:worker) }
      let!(:manual_order) { create(:manual_order, first_name: 'John', last_name: 'Doe', phone_number: '380951131020') }
      let!(:client) { create(:client, first_name: 'John', last_name: 'Doe', phone_number: '380951131020') }

      it 'chech not create new client if find client in DB' do
        Rake::Task['client_find_or_create:manual_order'].invoke

        expect(Client.count).to eq(1)
        expect(manual_order.reload.client_id).to eq(manual_order.client_id)
        expect(manual_order.reload.worker_id).to eq(manual_order.client_id)
      end
    end

    context 'when phone is with code and order is without code' do
      let!(:worker) { create(:worker) }
      let!(:manual_order) { create(:manual_order, first_name: 'John', last_name: 'Doe', phone_number: '0951130020') }
      let!(:client) { create(:client, first_name: 'John', last_name: 'Doe', phone_number: '380951130020') }

      it 'not create new client in DB' do
        Rake::Task['client_find_or_create:manual_order'].invoke

        expect(Client.count).to eq(1)
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass, RSpec/LetSetup
