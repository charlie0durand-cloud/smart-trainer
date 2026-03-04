class RoutinesController < ApplicationController
  before_action :set_routines, only: %i[show]

  layout "home", only: [:show]

  def index
    @routines = current_user.routines
  end

  def show
    @routines = current_user.routines
    @exercices = @routine.exercice
  end

  def new
    @routine = Routine.new
    @routines = current_user.routines
  end

  def create
    @routine = Routine.new(routine_params)
    @routine.user = current_user
    if @routine.save
      redirect_to root_path
    else
      @routines = current_user.routines
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    @routine = Routine.find(params[:id])
    @routine.destroy
    redirect_to root_path
  end

  private

  def set_routines
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:name)
  end
end
