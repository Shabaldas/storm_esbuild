class CreateFeedbackCall < ActiveRecord::Migration[7.0]
  def change
    create_table :feedback_calls do |t|
      t.string :phone_number, null: false
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end
