describe '/static_pages/home', type: :request do
  describe 'GET /static_pages/home' do
    context 'when user is not logged in' do
      it 'display home page' do
        get root_path

        expect(response).to be_successful
        expect(response.body).to include('Main')
        expect(response.body).to include(root_path)
        expect(response.body).not_to include('Store')
        expect(response.body).not_to include(products_path)
        expect(response.body).to include(printing_path)
        expect(response.body).to include(modeling_path)
        expect(response.body).to include(rendering_path)
        expect(response.body).to include('Do you have any questions?')
        expect(response.body).to include(save_phone_number_path)
      end
    end

    context 'when user is logged in' do
      let(:user) { create(:user, :admin) }
      let(:telegram_api_double) { instance_double(Telegram::Bot::Api) }
      let(:phone_number) { '1234567890' }

      before do
        login_as(user, scope: :user)
        allow(Telegram::Bot::Api).to receive(:new).and_return(telegram_api_double)
        allow(telegram_api_double).to receive(:call)
      end

      it 'display home page' do
        get root_path

        expect(response).to be_successful
        expect(response.body).to include('Main')
        expect(response.body).to include(root_path)
        expect(response.body).to include('Store')
        expect(response.body).to include(products_path)
        expect(response.body).to include('Do you have any questions?')
        expect(response.body).to include(save_phone_number_path)
      end
    end
  end

  describe 'POST /static_pages/feedback' do
    context 'when valid params' do
      let(:stubed_request) do
        stub_request(:post, /api.telegram.org/)
          .and_return(status: 200, body: '', headers: {})
      end
      let(:telegram_api_double) { instance_double(Telegram::Bot::Api) }
      let(:phone_number) { '+380673646509' }

      before do
        stubed_request
        allow(Telegram::Bot::Api).to receive(:new).and_return(telegram_api_double)
        allow(telegram_api_double).to receive(:call)
      end

      context 'when user is not logged in' do
        it 'creates feedback call' do
          expect do
            post save_phone_number_path, params: { feedback_call: { phone_number: '+380976404050' } }
          end.to change(FeedbackCall, :count).by(1)

          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is logged in' do
        let(:user) { create(:user, :admin) }
        let(:stubed_request) do
          stub_request(:post, /api.telegram.org/)
            .and_return(status: 200, body: '', headers: {})
        end

        before do
          login_as(user, scope: :user)
          stubed_request
        end

        it 'creates feedback call' do
          expect do
            post save_phone_number_path, params: { feedback_call: { phone_number: '+380976404050' } }
          end.to change(FeedbackCall, :count).by(1)

          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when invalid params' do
      let(:stubed_request) do
        stub_request(:post, /api.telegram.org/)
          .and_return(status: 200, body: '', headers: {})
      end

      before do
        stubed_request
      end

      it 'does not create feedback call' do
        expect do
          post save_phone_number_path, params: { feedback_call: { phone_number: '' } }
        end.not_to change(FeedbackCall, :count)
      end
    end
  end
end
