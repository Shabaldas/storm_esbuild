RSpec.describe User do
  describe '.enums' do
    it { is_expected.to define_enum_for(:role).with_values([:customer, :admin, :manager]) }
  end

  describe '.customer' do
    let(:customer) { create(:user) }

    it 'return user with default role' do
      expect(customer.role).to eq('customer')
    end
  end

  describe '.admin' do
    let(:admin) { create(:user, :admin) }

    it 'return user with role admin' do
      expect(admin.role).to eq('admin')
    end
  end
end
