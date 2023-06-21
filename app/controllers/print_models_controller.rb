# frozen_string_literal: true

class PrintModelsController < ApplicationController
  def new
    @print_model = PrintModel.new
    @print_model.print_model_attributes.build
  end

  def manage
  end
end
