# frozen_string_literal: true

module Dredd
  class PrintersController < BaseController
    before_action :set_printer, only: [:edit, :update, :destroy]

    def index
      @pagy, @printers = pagy(Printer.all, items: 10)
    end

    def new
      @printer = Printer.new
      @printer.printer_maintenances.build
    end

    def edit; end

    def create
      @printer = Printer.new(printer_params)
      if @printer.save
        redirect_to dredd_printers_path, notice: 'Printer was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @printer.update(printer_params)
        redirect_to dredd_printers_path, notice: 'Printer was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @printer.destroy
      redirect_to dredd_printers_path, notice: 'Printer was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def printer_params
      params.require(:printer).permit(:printer_code, :firm, :model, :printing_technology, :state,
                                      :type_mechanic, :table_size, :price_for_printer, :bought,
                                      :comment, :by_for_upgrade,
                                      printer_maintenances_attributes: [:id, :problem, :problem_find, :time_for_fix, :_destroy])
    end

    def set_printer
      @printer = Printer.find(params[:id])
    end
  end
end
