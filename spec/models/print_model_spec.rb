RSpec.describe PrintModel do
  describe '.associations' do
    it { is_expected.to have_many(:print_model_attributes).dependent(:destroy) }
  end
end
