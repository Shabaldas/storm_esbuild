class CreateWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :workers do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :nickname

      t.timestamps
    end
  end
end
