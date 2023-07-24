# frozen_string_literal: true

module Dredd
  class PrinterMaintenancesController < BaseController
    def index
      @pagy, @printer_maintenances = pagy(PrinterMaintenance.all, items: 10)
    end

    def show; end

    def new
      @printer_maintenance = PrinterMaintenance.new
      @printer_maintenance.build_primary_printer_option(printer_maintenance: @printer_maintenance)
      @printer_maintenance.build_secondary_printer_option(printer: @printer_maintenance)
    end

    def edit; end

    def create
      @printer_maintenance = PrinterMaintenance.new(product_params)

      if @printer_maintenance.save
        redirect_to dredd_printer_maintenances_path, notice: 'Maintenance was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @printer_maintenance.destroy
      redirect_to dredd_printer_maintenances_path, notice: 'Maintenance was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def printer_params
      params.require(:printer_maintenance).permit(:printer, :problem, :problem_find, :time_for_fix)
    end
  end
end
