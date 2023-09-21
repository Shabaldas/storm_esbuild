describe Dredd::ManualOrderHelper do
  describe '#app_icon_contact' do
    delegate :app_icon_contact, to: :helper

    context 'when app contact is google' do
      let!(:manual_order) { create(:manual_order, app_contact: :google) }

      it 'returns google icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('google_icon')
      end
    end

    context 'when app contact is viber' do
      let!(:manual_order) { create(:manual_order, app_contact: :viber) }

      it 'returns viber icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('viber_icon')
      end
    end

    context 'when app contact is whatsapp' do
      let!(:manual_order) { create(:manual_order, app_contact: :whatsapp) }

      it 'returns whatsapp icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('whatsapp_icon')
      end
    end

    context 'when app contact is instagram' do
      let!(:manual_order) { create(:manual_order, app_contact: :instagram) }

      it 'returns instagram icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('instagram_icon')
      end
    end

    context 'when app contact is messenger' do
      let!(:manual_order) { create(:manual_order, app_contact: :messenger) }

      it 'returns messenger icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('messenger_icon')
      end
    end

    context 'when app contact is telegram' do
      let!(:manual_order) { create(:manual_order, app_contact: :telegram) }

      it 'returns telegram icon' do
        expect(app_icon_contact(manual_order.app_contact)).to eq('telegram_icon')
      end
    end
  end
end
