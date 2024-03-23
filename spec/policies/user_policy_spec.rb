# frozen_string_literal: true

describe UserPolicy do
  let(:user_first) { create(:user) }
  let(:user_second) { create(:user) }

  permissions :access? do
    it 'grants access if the current user is the same as the user being checked' do
      expect(described_class).to permit(user_first, user_first)
    end

    it 'denies access if the current user is different from the user being checked' do
      expect(described_class).not_to permit(user_first, user_second)
    end
  end
end
