class PagesController < ApplicationController
  layout "home"

  def home
    @routines = current_user.routines
  end
end
