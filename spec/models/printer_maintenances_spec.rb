RSpec.describe PrinterMaintenance do
  describe '.associations' do
    it { is_expected.to belong_to(:printer) }
  end
end
