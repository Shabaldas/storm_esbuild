describe '/dredd/manual_orders', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/manual_orders' do
    let(:manual_order_first) { create(:manual_order) }
    let(:manual_order_second) { create(:manual_order) }

    before do
      manual_order_first
      manual_order_second
    end

    it 'displays all manual orders' do
      get dredd_manual_orders_path

      expect(response).to be_successful
      expect(response.body).to include('PRINT CODE')
      expect(response.body).to include('FULL NAME')
      expect(response.body).to include('MOBILE PHONE')
      expect(response.body).to include('APP CONTACT')
      expect(response.body).to include('PRICE FOR MODELING')
      expect(response.body).to include('PRICE FOR PRINTING')
      expect(response.body).to include('COUNT')
      expect(response.body).to include('TOTAL PRICE')
      expect(response.body).to include('PREPAID EXPENSE')
      expect(response.body).to include('STATUS')
      expect(response.body).to include('DEADLINE')
      expect(response.body).to include('CREATED AT')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include(new_dredd_manual_order_path)
      expect(response.body).to include('Create Manual Order')
    end
  end

  describe 'GET /dredd/manual_orders/new' do
    it 'display new manual order form' do
      get new_dredd_manual_order_path

      expect(response).to be_successful
      expect(response.body).to include('New Manual Order')
      expect(response.body).to include('First name')
      expect(response.body).to include('Last name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('App contact')
      expect(response.body).to include('Email')
      expect(response.body).to include('Price for modeling')
      expect(response.body).to include('Price for printing')
      expect(response.body).to include('Count')
      expect(response.body).to include('Total price')
      expect(response.body).to include('Status')
      expect(response.body).to include('Prepaid expense')
      expect(response.body).to include('Print material')
      expect(response.body).to include('Print color')
      expect(response.body).to include('Printed on printers')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('Create Manual Order"')
    end
  end

  describe 'GET /dredd/manual_orders/:id' do
    let(:manual_order) do
      create(:manual_order,
             first_name: 'John', last_name: 'Doe', total_price: '500',
             phone_number: '0673646509', email: '3d.storm.des@gmail.com',
             app_contact: 'viber', price_for_printing: '200', count: '2',
             prepaid_expense: '200', print_color: 'White', print_material: 'PLA',
             printed_on_printers: ['Ender-3 Pro, Ultimaker'], comment: 'Comment')
    end

    it 'display manual order' do
      get dredd_manual_order_path(manual_order)

      expect(response).to be_successful
      expect(response.body).to include('Client Contacts')
      expect(response.body).to include('Printing Information')
      expect(response.body).to include('Price Information')
      expect(response.body).to include('Manual Order information')
      expect(response.body).to include('John Doe')
      expect(response.body).to include('0673646509')
      expect(response.body).to include('3d.storm.des@gmail.com')
      expect(response.body).to include('viber')
      expect(response.body).to include('200')
      expect(response.body).to include('2')
      expect(response.body).to include('500')
      expect(response.body).to include('White')
      expect(response.body).to include('PLA')
      expect(response.body).to include('Ender-3 Pro, Ultimaker')
      expect(response.body).to include('Comment')
    end
  end

  describe 'POST /dredd/manual_orders' do
    it 'create a new manual order' do
      expect do
        post dredd_manual_orders_path, params: {
          manual_order: {
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '0673646509',
            email: 'john@gmail.com',
            app_contact: 'viber',
            price_for_modeling: '100',
            price_for_printing: '200',
            count: '2',
            total_price: '500',
            prepaid_expense: '200',
            print_color: 'White',
            print_material: 'PLA',
            printed_on_printers: ['Ender-3 Pro'],
            comment: 'Just for fun',
            deadline: DateTime.now + 1.day
          }
        }
      end.to change(ManualOrder, :count).by(1)

      manual_order = ManualOrder.last
      expect(manual_order.first_name).to eq('John')
      expect(manual_order.last_name).to eq('Doe')
      expect(manual_order.phone_number).to eq('0673646509')
      expect(manual_order.email).to eq('john@gmail.com')
      expect(manual_order.app_contact).to eq('viber')
      expect(manual_order.price_for_modeling.to_s).to eq('100.0')
      expect(manual_order.price_for_printing.to_s).to eq('200.0')
      expect(manual_order.count).to eq(2)
      expect(manual_order.total_price.to_s).to eq('500.0')
      expect(manual_order.prepaid_expense.to_s).to eq('200.0')
      expect(manual_order.print_color).to eq('White')
      expect(manual_order.print_material).to eq('PLA')
      expect(manual_order.printed_on_printers).to include('Ender-3 Pro')
      expect(manual_order.comment).to eq('Just for fun')
      expect(manual_order.deadline).not_to be_nil
    end
  end

  describe 'DELETE /dredd/manual_orders/:id' do
    let(:manual_order_first) { create(:manual_order) }
    let(:manual_order_second) { create(:manual_order) }

    before do
      manual_order_first
      manual_order_second
    end

    it 'deletes the manual order' do
      expect do
        delete dredd_manual_order_path(manual_order_first)
      end.to change(ManualOrder, :count).by(-1)
      expect(response).to redirect_to(dredd_manual_orders_path)
      follow_redirect!
      expect(response.body).to include('Manual Order was successfully destroyed.')
    end
  end
end
