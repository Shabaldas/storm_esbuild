RSpec.describe OptionValue do
  describe 'associations' do
    it { is_expected.to belong_to(:option) }
  end
end
