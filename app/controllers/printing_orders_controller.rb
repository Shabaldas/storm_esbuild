# frozen_string_literal: true

class PrintingOrdersController < ApplicationController
  def index
    @printing_order = PrintingOrder.new
  end

  def create
    @printing_order = PrintingOrder.new(printing_order_params)

    if @printing_order.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to printing_orders_path }
      end
    else
      render :index
    end
  end

  def printing_in_your_city
    @city = params[:city]
    @printing_order = PrintingOrder.new

    # params
  end

  private

  def printing_order_params
    params.require(:printing_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end

  def find_matching_city(user_input)
    city_names = cities.map { |city| city[:english_name].downcase }
    fuzzy_match = FuzzyMatch.new(city_names)
    fuzzy_match.find(user_input)
  end
end
