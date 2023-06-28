describe '/order', type: :request do
  describe 'GET /checkout' do
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
end
