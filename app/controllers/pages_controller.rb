class PagesController < ApplicationController
  def index
    @universities =  University.order("students desc").limit(5)
  end

end
