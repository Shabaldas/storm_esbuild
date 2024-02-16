# frozen_string_literal: true

module Dredd
  class UsersController < BaseController
    def index
      @admins = User.where(role: :admin)
      @pagy, @customers = pagy(User.where(role: :customer), items: 20)
    end
  end
end
