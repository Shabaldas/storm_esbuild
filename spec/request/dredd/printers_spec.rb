describe '/dredd/printers', type: :request do
  let(:user) { create(:user, :admin) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /dredd/printers' do
    let(:printer_one) { create(:printer) }
    let(:printer_two) { create(:printer) }

    before do
      printer_one
      printer_two
    end

    it 'displays all printer' do
      get dredd_printers_path

      expect(response).to be_successful
      expect(response.body).to include('Printer code')
      expect(response.body).to include('Firm')
      expect(response.body).to include('Printing technology')
      expect(response.body).to include('State')
      expect(response.body).to include('Type mechanic')
      expect(response.body).to include('Table size')
      expect(response.body).to include('Price for printer')
      expect(response.body).to include('Bought')
      expect(response.body).to include('Comment')
      expect(response.body).to include('ACTIONS')
      expect(response.body).to include(new_dredd_printer_path)
      expect(response.body).to include(edit_dredd_printer_path(printer_one))
      expect(response.body).to include(edit_dredd_printer_path(printer_two))
      expect(response.body).to include('Add new printer')
    end
  end

  describe 'GET /dredd/printers/new' do
    it 'display new printer form' do
      get new_dredd_printer_path

      expect(response).to be_successful
      expect(response.body).to include('Printer code')
      expect(response.body).to include('Firm')
      expect(response.body).to include('Model')
      expect(response.body).to include('Printing technology')
      expect(response.body).to include('State')
      expect(response.body).to include('Type mechanic')
      expect(response.body).to include('Table size')
      expect(response.body).to include('Price for printer')
      expect(response.body).to include('Bought')
      expect(response.body).to include('Comment')
      expect(response.body).to include('By for upgrade')
      expect(response.body).to include('Save')
    end
  end

  describe 'POST /dredd/printers' do
    it 'create a new printer' do
      expect do
        post dredd_printers_path, params: {
          printer: {
            printer_code: '#0001',
            firm: 'Ultimaker',
            model: '2+ Extanded',
            printing_technology: 'fdm',
            state: 'satisfactory',
            type_mechanic: 'corexy',
            table_size: '200x200x300',
            price_for_printer: 30_000.0,
            bought: DateTime.now - 1.year,
            comment: 'Comment',
            by_for_upgrade: 'To do'
          }
        }
      end.to change(Printer, :count).by(1)

      printer = Printer.last
      expect(printer.printer_code).to eq('#0001')
      expect(printer.firm).to eq('Ultimaker')
      expect(printer.model).to eq('2+ Extanded')
      expect(printer.printing_technology).to eq('fdm')
      expect(printer.state).to eq('satisfactory')
      expect(printer.type_mechanic).to eq('corexy')
      expect(printer.table_size).to eq('200x200x300')
      expect(printer.price_for_printer.to_s).to eq('30000.0')
      expect(printer.bought.to_s).not_to be_nil
      expect(printer.comment).to eq('Comment')
      expect(printer.by_for_upgrade).to eq('To do')
    end
  end

  describe 'PUT /dredd/printers/:id' do
    let!(:printer) { create(:printer, type_mechanic: :delta, printing_technology: :dlp) }

    let(:params) do
      {
        printer: {
          printer_code: '#0001',
          firm: 'Ultimaker',
          model: '2+ Extanded',
          printing_technology: 'fdm',
          state: 'satisfactory',
          type_mechanic: 'corexy',
          table_size: '200x200x300',
          price_for_printer: 30_000.0,
          bought: DateTime.now - 1.year,
          comment: 'Comment',
          by_for_upgrade: 'To do'
        }
      }
    end

    it 'update manual order' do
      expect do
        put(dredd_printer_path(printer), params:)
        printer.reload
      end.to change(Printer, :count).by(0) # rubocop:disable RSpec/ChangeByZero
          .and change(printer, :printer_code).from('PRINTER1').to('#0001')
          .and change(printer, :firm).from('Creality').to('Ultimaker')
          .and change(printer, :model).from('Ender 3').to('2+ Extanded')
          .and change(printer, :printing_technology).from('dlp').to('fdm')
          .and change(printer, :state).from('perfect').to('satisfactory')
          .and change(printer, :type_mechanic).from('delta').to('corexy')
          .and change(printer, :table_size).from('220x220x250').to('200x200x300')
          .and change(printer, :price_for_printer).from(10_000.0).to(30_000.0)
          .and change(printer, :comment).from(nil).to('Comment')
          .and change(printer, :by_for_upgrade).from(nil).to('To do')

      expect(response).to redirect_to(dredd_printers_path)
      follow_redirect!
      expect(response.body).to include('Printer was successfully updated.')
    end
  end

  describe 'DELETE /dredd/printers/:id' do
    let(:printer_first) { create(:printer) }
    let(:printer_second) { create(:printer) }

    before do
      printer_first
      printer_second
    end

    it 'deletes the manual order' do
      expect do
        delete dredd_printer_path(printer_first)
      end.to change(Printer, :count).by(-1)
      expect(response).to redirect_to(dredd_printers_path)
      follow_redirect!
      expect(response.body).to include('Printer was successfully destroyed.')
    end
  end
end
