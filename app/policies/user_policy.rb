# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  include ApplicationHelper

  attr_reader :current_user, :model

  def initialize(current_user, model) # rubocop:disable Lint/MissingSuper
    @current_user = current_user
    @user = model
  end

  def access?
    return true if @current_user == @user

    false
  end
end
