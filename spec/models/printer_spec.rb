RSpec.describe Printer do
  describe '.associations' do
    it { is_expected.to have_many(:printer_maintenances).dependent(:destroy) }
  end
end
