class CreateMonthlyMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :monthly_memos do |t|

      t.references :monthly_goal, foreign_key: true
      t.string :memo, null: false

      t.timestamps
    end
  end
end
