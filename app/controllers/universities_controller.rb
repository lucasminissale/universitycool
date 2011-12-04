class UniversitiesController < ApplicationController
  def index
    u = University.first
    @months, @money = UniversityData.presupuestos(u)
  end

end
