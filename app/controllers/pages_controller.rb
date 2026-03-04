class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    # @routines = current_user.routines
  end
end
