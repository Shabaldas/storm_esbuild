RSpec.describe Worker do
  it { is_expected.to belong_to(:user).optional }
  it { is_expected.to have_many(:manual_orders) }
  it { is_expected.to validate_presence_of(:first_name) }
end
