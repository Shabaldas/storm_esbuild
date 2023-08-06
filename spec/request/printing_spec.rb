describe '/printing_orders', type: :request do
  describe 'GET /static_pages/index' do
    let(:user) { create(:user, :admin) }

    before do
      login_as(user, scope: :user)
    end

    context 'when user is not logined' do
      it 'display printing page' do
        get printing_path

        expect(response).to be_successful
        expect(response.body).to include('Printing')
        expect(response.body).to include(printing_path)
        expect(response.body).to include('Service')
        expect(response.body).to include('FDM')
        expect(response.body).to include('SLA')
        expect(response.body).to include('DLP')
        expect(response.body).to include('Price')
        expect(response.body).to include('Quantity')
        expect(response.body).to include('Layer height')
      end
    end
  end

  describe 'POST /printing_orders/create' do
    context 'when valid data' do
      let(:stubed_request) do
        stub_request(:post, /api.telegram.org/)
          .and_return(status: 200, body: '', headers: {})
      end

      before do
        stubed_request
      end

      context 'without attached files' do
        it 'create printing order' do
          expect do
            post printing_orders_path, params: {
              printing_order: {
                first_name: 'John',
                last_name: 'Doe',
                email: 'example@example.com',
                phone_number: '+380976404050',
                link_to_model: 'https://www.thingiverse.com/thing:2789086',
                comment: 'Test comment'
              }
            }
          end.to change(PrintingOrder, :count).by(1)

          printing_order = PrintingOrder.last
          expect(printing_order.first_name).to eq('John')
          expect(printing_order.last_name).to eq('Doe')
          expect(printing_order.email).to eq('example@example.com')
          expect(printing_order.phone_number).to eq('+380976404050')
          expect(printing_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
          expect(printing_order.comment).to eq('Test comment')
        end
      end

      context 'with attached files' do
        let(:attachment_file_name) { './spec/fixtures/files/3d_stl_model.stl' }
        let(:params) do
          {
            printing_order: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'example@example.com',
              phone_number: '+380976404050',
              link_to_model: 'https://www.thingiverse.com/thing:2789086',
              comment: 'Test comment',
              files: [
                fixture_file_upload(attachment_file_name)
              ]
            }
          }
        end

        it 'create printing order' do
          expect do
            post(printing_orders_path, params:)
          end.to change(PrintingOrder, :count).by(1)
             .and change(ActiveStorage::Attachment, :count).by(1)
             .and change(ActiveStorage::Blob, :count).by(1)
          printing_order = PrintingOrder.last
          expect(printing_order.files).to be_attached
          expect(printing_order.link_to_model).to eq('https://www.thingiverse.com/thing:2789086')
        end
      end
    end

    context 'when invalid data' do
      it 'does not create printing order' do
        expect do
          post printing_orders_path, params: {
            printing_order: {
              first_name: '',
              last_name: 'John',
              link_to_model: 'invalid_link',
              email: 'invalid_phone'
            }
          }
        end.not_to change(PrintingOrder, :count)
      end
    end
  end
end
