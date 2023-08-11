RSpec.describe PrintingOrder do
  describe '.validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.not_to validate_content_type_of(:files).rejecting(:obj, :stl, :zip, :rar, '7z') }
    it { is_expected.to validate_size_of(:files).less_than_or_equal_to(150.megabytes) }
  end

  describe '.enums' do
    it { is_expected.to define_enum_for(:status).with_values([:unpaid, :paid]) }
  end
end
