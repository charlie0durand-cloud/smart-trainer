class RoutinesController < ApplicationController
  def index
    @routines = Routine.all
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

  def routine_params
    params.require(:routine).permit(:name)
  end
end
