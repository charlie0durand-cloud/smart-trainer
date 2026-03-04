class RoutinesController < ApplicationController
  before_action :set_routines, only: %i[show]

  def index
    @routines = Routine.all
    @routines = current_user.routines
  end

  def show
    @routine = Routine.find(params[:id])
    @routines = current_user.routines
  end

  def new
    @routine = Routine.new
  end

  def create
  @routine = Routine.new(routine_params)
  @routine.user = current_user
  if @routine.save
    redirect_to root_path
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
