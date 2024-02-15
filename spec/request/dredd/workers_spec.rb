describe '/dredd/workers', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/workers' do
    let(:worker_first) { create(:worker, user_id: user.id) }
    let(:worker_second) { create(:worker, user_id: user.id) }

    before do
      worker_first
      worker_second
    end

    it 'display new form from turbo fream' do
      get new_dredd_worker_path, as: :turbo_stream
      expect(response).to be_successful
      expect(response.body).to include('Please input')
      expect(response.body).to include('Save')
    end

    it 'get all workers' do
      get dredd_workers_path
      expect(response.body).to include(worker_first.first_name)
      expect(response.body).to include(worker_first.last_name)
      expect(response.body).to include(worker_first.nickname)
    end
  end

  describe 'POST /dredd/workers' do
    it 'create a new worker' do
      expect do
        post dredd_workers_path, params: {
          worker: {
            first_name: 'Vasa',
            last_name: 'Pupkin',
            nickname: 'Vasa 111'
          }
        }
      end.to change(Worker, :count).by(1)
      worker = Worker.last
      expect(worker.first_name).to eq('Vasa')
      expect(worker.last_name).to eq('Pupkin')
      expect(worker.nickname).to eq('Vasa 111')
    end

    it 'error when create a new worker' do
      expect do
        post dredd_workers_path, params: {
          worker: {
            last_name: 'Pupkin',
            nickname: 'Vasa 111'
          }
        }
      end.not_to change(Worker, :count)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Can&#39;t be blank')
    end
  end

  describe 'PUT /dredd/worker/:id' do
    let!(:worker) { create(:worker) }

    let(:params) do
      {
        worker: {
          last_name: 'Pupkin',
          nickname: 'Vasa 111'
        }
      }
    end

    it 'update worker' do
      expect do
        put(dredd_worker_path(worker), params:)
        worker.reload
      end.to change(Worker, :count).by(0) # rubocop:disable RSpec/ChangeByZero
          .and change(worker, :last_name).from(worker.last_name).to('Pupkin')
          .and change(worker, :nickname).from(worker.nickname).to('Vasa 111')
      worker = Worker.last
      expect(worker.last_name).to eq('Pupkin')
      expect(worker.nickname).to eq('Vasa 111')
      expect(response.body).to include('Worker was successfully updated.')
    end
  end

  describe 'DELETE /dredd/workers/:id' do
    let(:worker) { create(:worker, user_id: user.id) }

    before do
      worker
    end

    it 'deletes the workers' do
      expect do
        delete dredd_worker_path(worker)
      end.to change(Worker, :count).by(-1)
      expect(response.body).to include('Worker was successfully destroyed.')
    end
  end
end
