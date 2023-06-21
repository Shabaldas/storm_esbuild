RSpec.describe PrintModelAttribute do
  describe '.associations' do
    it { is_expected.to belong_to(:print_model) }
  end
end
