class CreatePortfolioTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_translations do |t|
      t.string :locale, index: true
      t.references :portfolio, index: true
      t.string :name
      t.string :category_name
      t.string :description

      t.timestamps
    end
  end
end
