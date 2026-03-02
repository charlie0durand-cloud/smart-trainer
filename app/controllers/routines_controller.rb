class RoutinesController < ApplicationController
  before_action set_routines, only: %i[show]
  def index
    @routines = Routine.all
  end

  def show
  end

  def new
    @routine = Routine.new()
  end

  def create
    @user = User.find(params[:id])
    @routine = Routine.new(routine_params)
    @routine.user = @user
    if @routine.save
      redirect_to home_path
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_routines
    @routine = Routine.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:name)
  end
end
