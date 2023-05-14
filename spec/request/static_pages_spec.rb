describe '/static_pages/home', type: :request do
  describe 'GET /static_pages/home' do
    context 'when user is not logged in' do
      it 'display home page' do
        get root_path

        expect(response).to be_successful
        expect(response.body).to include('Head')
        expect(response.body).to include(root_path)
        expect(response.body).to include('Store')
        expect(response.body).to include(products_path)
        expect(response.body).to include('Do you have any questions?')
        expect(response.body).to include(save_phone_number_path)
      end
    end

    context 'when user is logged in' do
      let(:user) { create(:user, :admin) }

      before do
        login_as(user, scope: :user)
      end

      it 'display home page' do
        get root_path

        expect(response).to be_successful
        expect(response.body).to include('Head')
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
      context 'when user is not logged in' do
        it 'creates feedback call' do
          expect do
            post save_phone_number_path, params: { feedback_call: { phone_number: '+380123456789' } }
          end.to change(FeedbackCall, :count).by(1)

          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is logged in' do
        let(:user) { create(:user, :admin) }

        before do
          login_as(user, scope: :user)
        end

        it 'creates feedback call' do
          expect do
            post save_phone_number_path, params: { feedback_call: { phone_number: '+380123456789' } }
          end.to change(FeedbackCall, :count).by(1)

          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when invalid params' do
      it 'does not create feedback call' do
        expect do
          post save_phone_number_path, params: { feedback_call: { phone_number: '' } }
        end.not_to change(FeedbackCall, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
