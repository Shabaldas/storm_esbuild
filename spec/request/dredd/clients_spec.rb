describe '/dredd/clients', type: :request do
  let(:user) { create(:user, :admin) }
  let(:client) { create(:client) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/clients' do
    context 'when user is admin' do
      let(:client_first) { create(:client) }
      let(:client_second) { create(:client) }
      let(:client_third) { create(:client) }

      before do
        client_first
        client_second
        client_third
      end

      it 'display all clients' do
        get dredd_clients_path
        expect(response).to be_successful
        expect(response.body).to include('ID')
        expect(response.body).to include('FIRST NAME')
        expect(response.body).to include('LAST NAME')
        expect(response.body).to include('NICKNAME')
        expect(response.body).to include('EMAIL')
        expect(response.body).to include('PHONE')
        expect(response.body).to include('CREATED AT')
        expect(response.body).to include(client_first.id.to_s)
        expect(response.body).to include(client_second.id.to_s)
        expect(response.body).to include(client_third.id.to_s)
        expect(response.body).to include(html_escape(client_first.first_name))
        expect(response.body).to include(html_escape(client_second.first_name))
        expect(response.body).to include(html_escape(client_third.first_name))
        expect(response.body).to include(html_escape(client_first.last_name))
        expect(response.body).to include(html_escape(client_second.last_name))
        expect(response.body).to include(html_escape(client_third.last_name))
        expect(response.body).to include(client_first.phone_number)
        expect(response.body).to include(client_second.phone_number)
        expect(response.body).to include(client_third.phone_number)
      end
    end

    context 'when user is not admin' do
      let(:user) { create(:user) }

      it 'redirect to root path' do
        get dredd_clients_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end
  end

  describe 'POST /dredd/clients' do
    it 'create a new client' do
      expect do
        post dredd_clients_path, params: {
          client: {
            first_name: 'Vasa',
            last_name: 'Pupkin',
            nickname: 'Vasa 111'
          }
        }, as: :turbo_stream
      end.to change(Client, :count).by(1)
      client = Client.last
      expect(client.first_name).to eq('Vasa')
      expect(client.last_name).to eq('Pupkin')
      expect(client.nickname).to eq('Vasa 111')
    end

    it 'error when create a new client' do
      expect do
        post dredd_clients_path, params: {
          client: {
            last_name: 'Pupkin',
            nickname: 'Vasa 111'
          }
        }
      end.not_to change(Client, :count)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Can&#39;t be blank')
    end
  end

  describe 'GET /dredd/client/:id' do
    it 'display the client' do
      get dredd_client_path(client)

      expect(response).to be_successful
      expect(response.body).to include(client.first_name)
      expect(response.body).to include(client.last_name)
      expect(response.body).to include(client.email)
      expect(response.body).to include(client.phone_number)
      expect(response.body).to include(client.nickname)
    end
  end

  describe 'PUT /dredd/client/:id' do
    let(:params) do
      {
        client: {
          first_name: 'Pupkin',
          last_name: 'Vasa'
        }
      }
    end

    it 'update client' do
      expect do
        put(dredd_client_path(client), params:, as: :turbo_stream)
        client.reload
      end.to change(Client, :count).by(0) # rubocop:disable RSpec/ChangeByZero
          .and change(client, :first_name).from(client.first_name).to('Pupkin')
          .and change(client, :last_name).from(client.last_name).to('Vasa')
      expect(response.body).to include('Client was successfully updated.')
    end
  end
end
