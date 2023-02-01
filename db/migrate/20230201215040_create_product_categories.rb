class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.string :name
      t.text :description
      t.string :ancestry

      t.timestamps
    end
    add_index :product_categories, :ancestry
  end
end