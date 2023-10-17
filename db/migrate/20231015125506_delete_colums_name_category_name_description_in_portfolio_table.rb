class DeleteColumsNameCategoryNameDescriptionInPortfolioTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :portfolios, :name, :string
    remove_column :portfolios, :category_name, :string
    remove_column :portfolios, :description, :string
  end
end
