RSpec.describe ManualOrder do
  describe 'enums' do
    it { is_expected.to define_enum_for(:app_contact).with_values([:google, :viber, :whatsapp, :instagram, :messenger, :telegram]) }
    it { is_expected.to define_enum_for(:status).with_values([:unpaid, :paid]) }
    it { is_expected.to define_enum_for(:workflow_status).with_values([:nothing, :modeling, :printing, :called_cleint, :done]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:worker).optional }
    it { is_expected.to belong_to(:client).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_presence_of(:worker_id).on(:update) }
  end
end
