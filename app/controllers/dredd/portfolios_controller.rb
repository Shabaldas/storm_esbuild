# frozen_string_literal: true

module Dredd
  class PortfoliosController < BaseController
    before_action :set_portfolio, only: [:edit, :update, :destroy]

    def index
      @pagy, @portfolios = pagy(Portfolio.with_attached_main_picture.order(:portfolio_type), items: 20)
    end

    def new
      @portfolio = Portfolio.new
    end

    def edit; end

    def create
      @portfolio = Portfolio.new(portfolio_params)

      if @portfolio.save
        redirect_to dredd_portfolios_path, notice: { text: 'Portfolio was successfully created.', icon: 'success_icon' }
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @portfolio.update(portfolio_params)
        redirect_to dredd_portfolios_path, notice: { text: 'Portfolio was successfully updated.', icon: 'success_icon' }
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @portfolio.destroy
      redirect_to dredd_portfolios_path, error: { text: 'Portfolio was successfully destroyed.', icon: 'attention' }
    end

    private

    def portfolio_params
      params.require(:portfolio).permit(:name, :description, :category_name, :status, :main_picture, :portfolio_type, :tags, :created_by_machine)
    end

    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end
  end
end
