class CreateRoutines < ActiveRecord::Migration[8.1]
  def change
    create_table :routines do |t|
      t.string :name
      t.integer :duration_in_seconds
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
