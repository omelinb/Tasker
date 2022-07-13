class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_enum :status, %w[new in_progress completed canceled]

    create_table :tasks do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false, index: true
      t.integer :approves_count, null: false, default: 0
      t.enum :status, enum_type: "status", default: "new", null: false

      t.datetime :deadline_at
      t.datetime :completed_at
      t.datetime :canceled_at

      t.timestamps
    end
  end
end
