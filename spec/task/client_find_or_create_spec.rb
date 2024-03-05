# rubocop:disable RSpec/DescribeClass
RSpec.describe 'client_find_or_create Rake Task' do
  before do
    Rake.application.load_rakefile
    Rake::Task.define_task(:environment)
  end

  describe 'client_find_or_create:manual_order' do
    it 'creates clients from manual orders' do
      worker = create(:worker)
      manual_order = create(:manual_order, worker_id: worker.id)
      create_list(:manual_order, 5, worker_id: worker.id)

      Rake::Task['client_find_or_create:manual_order'].invoke

      expect(Client.count).to eq(6)
      expect(manual_order.reload.client_id).to eq(Client.first.id)
      expect(manual_order.reload.worker_id).to eq(Worker.first.id)
    end

    it 'does not create a new client if already exists' do
      manual_order = create(:manual_order, first_name: 'John', last_name: 'Doe', phone_number: '380951130020')
      create(:client, first_name: 'John', last_name: 'Doe', phone_number: '380951130020')
      create(:worker)

      Rake::Task['client_find_or_create:manual_order'].invoke

      expect(Client.count).to eq(1)
      expect(manual_order.reload.client_id).to eq(manual_order.client_id)
      expect(manual_order.reload.worker_id).to eq(manual_order.client_id)
    end
  end
end
# rubocop:enable RSpec/DescribeClass
