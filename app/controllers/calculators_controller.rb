# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :authorize_admin

  def index; end

  private

  def authorize_admin
    authorize :admin, :access?
  end
end
