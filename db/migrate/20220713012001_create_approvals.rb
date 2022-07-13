class CreateApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :approvals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.index %i[user_id task_id], unique: true

      t.timestamps
    end
  end
end
