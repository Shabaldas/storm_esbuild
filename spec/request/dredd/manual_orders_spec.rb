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
      expect(response.body).to include('Print Code')
      expect(response.body).to include('Full Name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('Application contact')
      expect(response.body).to include('Prepaid expense')
      expect(response.body).to include('Status')
      expect(response.body).to include('Status')
      expect(response.body).to include('Actions')
      expect(response.body).to include(edit_dredd_manual_order_path(manual_order_first))
      expect(response.body).to include(edit_dredd_manual_order_path(manual_order_second))
    end
  end

  describe 'GET /dredd/manual_orders/new_manual_order' do
    it 'display new manual order form' do
      get new_manual_order_dredd_manual_orders_path

      expect(response).to be_successful
      expect(response.body).to include('New Manual Order')
      expect(response.body).to include('First name')
      expect(response.body).to include('Last name')
      expect(response.body).to include('Phone number')
      expect(response.body).to include('Application contact')
      expect(response.body).to include('Email')
      expect(response.body).to include('Modeller')
      expect(response.body).to include('Price for modeling')
      expect(response.body).to include('Price for printing')
      expect(response.body).to include('Quality')
      expect(response.body).to include('Infill')
      expect(response.body).to include('Count')
      expect(response.body).to include('Total price')
      expect(response.body).to include('Status')
      expect(response.body).to include('Prepaid expense')
      expect(response.body).to include('Print material')
      expect(response.body).to include('Print color')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('FOP accounting')
      expect(response.body).to include('Save')
    end
  end

  describe 'GET /dredd/manual_orders/new_manual_order_from_client_dredd_manual_orders_path' do
    it 'display new manual order form' do
      get new_manual_order_from_client_dredd_manual_orders_path

      expect(response).to be_successful
      expect(response.body).to include('Select client')
      expect(response.body).to include('Modeller')
      expect(response.body).to include('Price for modeling')
      expect(response.body).to include('Price for printing')
      expect(response.body).to include('Quality')
      expect(response.body).to include('Infill')
      expect(response.body).to include('Count')
      expect(response.body).to include('Total price')
      expect(response.body).to include('Status')
      expect(response.body).to include('Prepaid expense')
      expect(response.body).to include('Print material')
      expect(response.body).to include('Print color')
      expect(response.body).to include('Deadline')
      expect(response.body).to include('Comment')
      expect(response.body).to include('FOP accounting')
      expect(response.body).to include('Save')
    end
  end

  describe 'POST /dredd/manual_orders' do
    let!(:worker) { create(:worker) }

    it 'create a new manual order' do
      expect do
        post dredd_manual_orders_path, params: {
          manual_order: {
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '0673646509',
            email: 'john@gmail.com',
            app_contact: 'viber',
            worker_id: worker.id,
            price_for_modeling: '100',
            price_for_printing: '200',
            count: '2',
            total_price: '500',
            prepaid_expense: '200',
            print_color: 'White',
            print_material: 'PLA',
            comment: 'Just for fun',
            quality: '0.1mm',
            need_to_call_client: true,
            infill: '50%',
            deadline: DateTime.now + 1.day,
            individual_entrepreneur_accountings: true
          }
        }
      end.to change(ManualOrder, :count).by(1)

      manual_order = ManualOrder.last
      expect(manual_order.first_name).to eq('John')
      expect(manual_order.last_name).to eq('Doe')
      expect(manual_order.phone_number).to eq('0673646509')
      expect(manual_order.email).to eq('john@gmail.com')
      expect(manual_order.app_contact).to eq('viber')
      expect(manual_order.worker.full_name).to eq(worker.full_name)
      expect(manual_order.price_for_modeling.to_s).to eq('100.0')
      expect(manual_order.price_for_printing.to_s).to eq('200.0')
      expect(manual_order.count).to eq(2)
      expect(manual_order.total_price.to_s).to eq('500.0')
      expect(manual_order.prepaid_expense.to_s).to eq('200.0')
      expect(manual_order.print_color).to eq('White')
      expect(manual_order.print_material).to eq('PLA')
      expect(manual_order.comment).to eq('Just for fun')
      expect(manual_order.quality).to eq('0.1mm')
      expect(manual_order.need_to_call_client).to be(true)
      expect(manual_order.infill).to eq('50%')
      expect(manual_order.deadline).not_to be_nil
      expect(manual_order.individual_entrepreneur_accountings).to be(true)
    end
  end

  describe 'PUT /dredd/manual_orders/:id' do
    context 'when valid params' do
      context 'when modeller selected' do
        let!(:manual_order) do
          create(:manual_order,
                 first_name: 'John', last_name: 'Doe', total_price: 500, need_to_call_client: true,
                 phone_number: '0673646509', email: '3d.storm.des@gmail.com', status: 'unpaid',
                 quality: '0.1mm', infill: '50%', print_color: 'Natural', prepaid_expense: nil,
                 price_for_modeling: '50', price_for_printing: '150', end_date: nil, workflow_status: 'modeling',
                 print_material: 'ABS', app_contact: 'viber', comment: 'Comment', individual_entrepreneur_accountings: true)
        end
        let!(:worker) { create(:worker) }

        let(:params) do
          {
            manual_order: {
              first_name: 'John',
              last_name: 'Doe',
              phone_number: '+380673646509',
              email: '3d.storm.des@gmail.com',
              app_contact: 'telegram',
              worker_id: worker.id,
              individual_entrepreneur_accountings: false,
              price_for_modeling: '100',
              price_for_printing: '200',
              count: '2',
              quality: '0.2mm',
              infill: '100%',
              total_price: '600',
              prepaid_expense: '200',
              status: 'unpaid',
              need_to_call_client: false,
              workflow_status: 'printing',
              print_color: 'White',
              print_material: 'PLA',
              comment: 'New comment',
              end_date: DateTime.now + 1.day
            }
          }
        end

        it 'update manual order' do
          expect do
            put(dredd_manual_order_path(manual_order), params:)
            manual_order.reload
          end.to change(ManualOrder, :count).by(0) # rubocop:disable RSpec/ChangeByZero
              .and change(manual_order, :app_contact).from('viber').to('telegram')
              .and change(manual_order, :phone_number).from('0673646509').to('+380673646509')
              .and change(manual_order, :comment).from('Comment').to('New comment')
              .and change(manual_order, :total_price).from(500.0).to(600.0)
              .and change(manual_order, :print_material).from('ABS').to('PLA')
              .and change(manual_order, :print_color).from('Natural').to('White')
              .and change(manual_order, :prepaid_expense).from(nil).to(200.0)
              .and change(manual_order, :workflow_status).from('modeling').to('printing')
              .and change(manual_order, :worker_id).from(nil).to(worker.id)
              .and change(manual_order, :price_for_modeling).from(50).to(100.0)
              .and change(manual_order, :price_for_printing).from(150).to(200.0)
              .and change(manual_order, :quality).from('0.1mm').to('0.2mm')
              .and change(manual_order, :need_to_call_client).from(true).to(false)
              .and change(manual_order, :infill).from('50%').to('100%')
              .and change(manual_order, :count).from(nil).to(2)
              .and change(manual_order, :end_date).from(nil).to(DateTime.now + 1.day)
              .and change(manual_order, :individual_entrepreneur_accountings).from(true).to(false)

          expect(manual_order.full_name).to eq('John Doe')
          expect(response).to redirect_to(edit_dredd_manual_order_path(manual_order))
          follow_redirect!
          expect(response.body).to include('Manual Order was successfully updated.')
        end
      end
    end

    context 'when invalid params' do
      let!(:manual_order) do
        create(:manual_order,
               first_name: 'John', last_name: 'Doe', total_price: 500,
               phone_number: '0673646509')
      end

      let(:params) do
        {
          manual_order: {
            first_name: '',
            last_name: 'Doe',
            phone_number: '',
            total_price: '',
            email: '3d.storm.des@gmail.com',
            app_contact: 'telegram'
          }
        }
      end

      it 'dispaly error for select modeller' do
        expect do
          put(dredd_manual_order_path(manual_order), params:)
          manual_order.reload
        end.to change(ManualOrder, :count).by(0) # rubocop:disable RSpec/ChangeByZero

        expect(response.body).to include(html_escape("Can't be blank"))
      end
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
