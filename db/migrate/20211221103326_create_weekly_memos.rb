class CreateWeeklyMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :weekly_memos do |t|

      t.references :weekly_goal, foreign_key: true
      t.string :memo, null: false

      t.timestamps
    end
  end
end
