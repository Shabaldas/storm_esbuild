# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def access?
    return true if user&.admin? || user&.manager?

    false
  end

  def admin_only_access?
    return true if user&.admin?

    false
  end
end
