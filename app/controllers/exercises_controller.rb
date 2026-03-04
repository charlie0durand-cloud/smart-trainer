class ExercisesController < ApplicationController
  def add_to_routine
    @exercice = Exercice.find(params[:id])
    @exercice.update(routine_id: params[:routine_id])
    redirect_back fallback_location: root_path
  end
end
