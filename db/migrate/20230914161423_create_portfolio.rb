class CreatePortfolio < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.string :name
      t.string :category_name
      t.integer :order
      t.string :description
      t.integer :status, default: 0
      t.integer :portfolio_type, default: 0
      t.string :tags
      t.string :created_by_machine

      t.timestamps
    end
  end
end
