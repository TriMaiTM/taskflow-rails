class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.date :due_on

      t.timestamps
    end

    add_index :tasks, [:project_id, :status]
    add_index :tasks, :due_on
  end
end
