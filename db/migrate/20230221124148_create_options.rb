class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :title
      t.integer :measurement

      t.timestamps
    end
  end
end
