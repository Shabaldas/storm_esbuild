RSpec.describe ManualOrder do
  describe 'enums' do
    it { is_expected.to define_enum_for(:app_contact).with_values([:telegram, :viber, :whatsapp, :instagram, :messenger, :google]) }
    it { is_expected.to define_enum_for(:status).with_values([:unpaid, :paid]) }
  end
end
