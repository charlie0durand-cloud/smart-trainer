class PagesController < ApplicationController
  def home
    @routines = current_user.routines
  end
end
