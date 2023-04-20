# rubocop:disable RSpec/RepeatedExample
describe ApplicationPolicy do
  let(:user) { build(:user) }
  let(:record) { build(:user) }

  permissions :show? do
    it 'denies show? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :create? do
    it 'denies create? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :edit? do
    it 'denies edit? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :update? do
    it 'denies update? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :destroy? do
    it 'denies destroy? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :index? do
    it 'denies index? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end

  permissions :new? do
    it 'denies new? by default' do
      expect(described_class).not_to permit(user, record)
    end
  end
  describe 'scope' do
    it 'raises an error by default' do
      expect { described_class::Scope.new(user, record.class).resolve }.to raise_error(NotImplementedError)
    end
  end
end
# rubocop:enable RSpec/RepeatedExample
