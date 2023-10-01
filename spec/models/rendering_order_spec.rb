RSpec.describe RenderingOrder do
  describe '.validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_size_of(:files).less_than_or_equal_to(150.megabytes) }

    it do
      expect(described_class).not_to validate_content_type_of(:files)
      .rejecting(:pdf, :doc, :docx, :xls, :xlsx,
                 :jpg, :jpeg, :png, :obj, :stl, :step, :stp, :igs,
                 :sldrt, :sldasm, :asm, :prt, :x_t, :x_b, :xmt_txt, :xmt_bin,
                 :zip, :rar, '7z')
    end
  end

  describe '.enums' do
    it { is_expected.to define_enum_for(:status).with_values([:unpaid, :paid]) }
  end
end
