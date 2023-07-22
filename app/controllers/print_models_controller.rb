# frozen_string_literal: true

class PrintModelsController < ApplicationController
  before_action :authorize_admin

  def new
    @print_model = PrintModel.new
    @print_model.print_model_attributes.build
  end

  def manage
    @print_model = PrintModel.find_or_initialize_by(id: print_model_params[:id])

    print_model_attribute = @print_model.print_model_attributes
                              .find_by(print_model_params.dig(:print_model_attributes_attributes, '0'))

    if print_model_attribute.present?
      print_model_attribute.cart_item.quantity += 1

      print_model_attribute.cart_item.save
    else
      if @print_model.persisted? && @print_model.name == print_model_params[:file].original_filename
        @print_model.assign_attributes(print_model_params.except(:file))
      else
        @print_model.assign_attributes(print_model_params)
        @print_model.name = print_model_params[:file].original_filename
      end
      @print_model.save

      @print_model.print_model_attributes.last.create_cart_item(cart_id: current_cart.id, quantity: 1)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          # turbo_stream.update('print_model_id_field', partial: 'form')
          turbo_stream.update('loaderwrapper', partial: 'loader')
        ]
      end
    end
  end

  private

  def print_model_params
    params.require(:print_model).permit(:id, :file, :size, :weight, :volume, print_model_attributes_attributes: [:material, :quality, :color, :subtotal_price])
  end

  def authorize_admin
    authorize :admin, :access?
  end
end
