# frozen_string_literal: true

module Admin
  class ProductCategoriesController < BaseController
    before_action :set_product_category, only: [:show, :edit, :update, :destroy]

    def index
      @pagy, @product_categories = pagy(ProductCategory.all, items: 10)
    end

    def show; end

    def new
      @product_category = ProductCategory.new
    end

    def edit; end

    def create
      @product_category = ProductCategory.new(product_category_params.except(:ancestry))

      parent_id = product_category_params[:ancestry]

      if parent_id.present?
        parent_category = ProductCategory.find_by(id: parent_id)
        parent_category.children.create!(product_category_params.except(:ancestry))

        redirect_to admin_product_categories_path, notice: 'Product category was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      elsif @product_category.save
        redirect_to admin_product_categories_path, notice: 'Product category was successfully created.' # rubocop:disable Rails/I18nLocaleTexts
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      ap '<<<<<<<<<<<<<<<'
      ap params.to_unsafe_h
      children_ids = params.dig(:product_category, :children)
      ap children_ids.mpa(&:blank?)
      
      if children_ids.any?
        @product_category.children.create!(children_ids)
        @product_category.update(product_category_params)
        redirect_to admin_product_categories_path, notice: 'Product category was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
      else
        if @product_category.update(product_category_params)
          redirect_to admin_product_categories_path, notice: 'Product category was successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

    def destroy
      @product_category.destroy
      redirect_to admin_product_categories_path, notice: 'Product category was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
    end

    private

    def product_category_params
      params.require(:product_category).permit(:id, :name, :description, :ancestry, children: [:id])
    end

    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end
  end
end
