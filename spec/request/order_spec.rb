describe '/order', type: :request do
  describe 'GET /checkout' do
    context 'when user admin' do
      let(:user) { create(:user, :admin) }

      before do
        login_as(user, scope: :user)
      end

      context 'when current cart order is empty' do
        it 'create new and order' do
          expect do
            get checkout_path
          end.to change(Order, :count).from(0).to(1)

          expect(response).to be_successful
          expect(response.body).to include('Head')
          expect(response.body).to include('Store')
          expect(response.body).to include('Calculator')
          expect(response.body).to include('Your Order')
          expect(response.body).to include('First name')
          expect(response.body).to include('Last name')
          expect(response.body).to include('Email')
          expect(response.body).to include('Mobile phone')
          expect(response.body).to include('Selected goods')
          expect(response.body).to include('Comment')
          expect(response.body).to include('Delivery')
          expect(response.body).to include('Total price')
          expect(response.body).to include('Payment')
        end
      end

      context 'when current cart is not empty' do
        it 'show existion order page' do
          get checkout_path

          expect(response).to be_successful
          expect(response.body).to include('Head')
          expect(response.body).to include('Store')
          expect(response.body).to include('Calculator')
          expect(response.body).to include('Your Order')
          expect(response.body).to include('First name')
          expect(response.body).to include('Last name')
          expect(response.body).to include('Email')
          expect(response.body).to include('Mobile phone')
          expect(response.body).to include('Selected goods')
          expect(response.body).to include('Comment')
          expect(response.body).to include('Delivery')
          expect(response.body).to include('Total price')
          expect(response.body).to include('Payment')
        end
      end
    end

    context 'when user not admin' do
      let(:user) { create(:user) }

      before do
        login_as(user, scope: :user)
      end

      it 'redirect to root path' do
        get checkout_path

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('Main')
        expect(response.body).not_to include('Calculator')
        expect(response.body).not_to include('Your Order')
      end
    end
  end
end
