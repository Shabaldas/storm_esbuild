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
    input_city_name = params[:city].downcase
    all_english_names = City.pluck(:english_name).map(&:downcase)
    all_ukrainian_names = City.pluck(:ukrainian_name).map(&:downcase)

    english_matcher = FuzzyMatch.new(all_english_names)
    ukrainian_matcher = FuzzyMatch.new(all_ukrainian_names)
    closest_english_match = english_matcher.find(input_city_name)
    closest_ukrainian_match = ukrainian_matcher.find(input_city_name)

    final_match = closest_english_match || closest_ukrainian_match

    if final_match.present?
      @city = City.find_by('lower(english_name) = ? OR lower(ukrainian_name) = ?', final_match.downcase, final_match.downcase)
    else
      redirect_to printing_path
    end
    @printing_order = PrintingOrder.new
  end

  private

  def printing_order_params
    params.require(:printing_order).permit(:first_name, :last_name, :email, :phone_number, :link_to_model, :comment, files: [])
  end
end
