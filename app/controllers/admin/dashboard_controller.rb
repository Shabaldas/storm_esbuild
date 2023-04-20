# frozen_string_literal: true

module Admin
  class DashboardController < BaseController
    def index
      @users_count = User.count
    end
  end
end
