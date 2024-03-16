RSpec.describe Portfolio do
  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values([:inactive, :active]) }
    it { is_expected.to define_enum_for(:portfolio_type).with_values([:modeling, :rendering, :printing, :scanning]) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'only allows image file' do
      portfolio = build(:portfolio)
      portfolio.main_picture = {
        io: File.new('./spec/fixtures/files/dummy.png'),
        filename: 'dummy.png'
      }
      expect(portfolio).to be_valid
    end
  end
end
