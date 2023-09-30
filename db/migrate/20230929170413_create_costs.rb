class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.string :name
      t.string :description
      t.decimal :amount
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
