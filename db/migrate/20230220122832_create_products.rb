class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :product_category, null: false, foreign_key: { on_delete: :cascade, to_table: :product_categories }
      t.integer :status, default: 0
      t.decimal :price, precision: 8, scale: 2, default: 0.0, null: false

      t.timestamps
    end
    add_index :products, :name
  end
end
