# frozen_string_literal: true

class PrintsController < ApplicationController
  def show
  end

  private

  def authorize_admin
    authorize :admin, :access?
  end
end
