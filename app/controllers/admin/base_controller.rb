# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authorize_admin
    
    add_flash_types :info, :error, :warning

    private

    def authorize_admin
      authorize :admin, :access?
    end
  end
end
