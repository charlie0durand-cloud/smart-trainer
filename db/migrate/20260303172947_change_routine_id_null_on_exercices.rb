class ChangeRoutineIdNullOnExercices < ActiveRecord::Migration[8.1]
  def change
    change_column_null :exercices, :routine_id, true
  end
end
