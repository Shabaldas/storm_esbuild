# frozen_string_literal: true

describe AdminPolicy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  permissions :access? do
    it 'allows admin to access admin pages' do
      expect(described_class).to permit(admin, :admin)
    end

    it 'does not allow user to access admin pages' do
      expect(described_class).not_to permit(user, :admin)
    end
  end
end
