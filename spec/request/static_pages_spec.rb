describe '/', type: :request do
  describe 'GET /' do
    context 'when user not logined' do
      it 'show home page' do
        get root_path
        # expect(response).to render_template(:home)
        expect(response.body).to include(root_path)
        expect(response.body).to include('Head')
        expect(response.body).to include('Store')
        expect(response.body).to include('3d Print')
        expect(response.body).to include('Modeling')
        expect(response.body).to include('Render')
        expect(response.body).to include('Print')
        expect(response.body).to include('Calculator')
        expect(response.body).to include('My Office')
        expect(response.body).to include('Contacts')
        expect(response.body).to include('Address')
      end
    end
  end
end
