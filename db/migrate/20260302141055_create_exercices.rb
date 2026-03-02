class CreateExercices < ActiveRecord::Migration[8.1]
  def change
    create_table :exercices do |t|
      t.string :video_url
      t.string :name
      t.string :description
      t.string :rep_amount
      t.string :objective
      t.references :chat, null: false, foreign_key: true
      t.references :routine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
