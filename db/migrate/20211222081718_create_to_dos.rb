class CreateToDos < ActiveRecord::Migration[6.1]
  def change
    create_table :to_dos do |t|

      t.references :weekly_goal, foreign_key: true
      t.string :goal, null: false
      t.boolean :complete_flag, default: false, null: false

      t.timestamps
    end
  end
end
