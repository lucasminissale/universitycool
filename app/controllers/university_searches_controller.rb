class UniversitySearchesController < ApplicationController

  def index
    @university_searches = UniversitySearch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @university_searches }
    end
  end


  def show
    #@university_search = UniversitySearch.find(params[:id])
    @universities = University.all
    @university_search = UniversitySearch.new
    @result = BudgetUniversity.new("remote object")
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @university_search }
    end
  end

  
  def new
    @university_search = UniversitySearch.new
    @universities = University.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @university_search }
    end
  end

  def edit
    @university_search = UniversitySearch.find(params[:id])
  end

 
  def create
    @university_search = UniversitySearch.new(params[:university_search])

    respond_to do |format|
      if @university_search.save
        format.html { redirect_to @university_search, notice: 'University search was successfully created.' }
        format.json { render json: @university_search, status: :created, location: @university_search }
      else
        format.html { render action: "new" }
        format.json { render json: @university_search.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @university_search = UniversitySearch.find(params[:id])

    respond_to do |format|
      if @university_search.update_attributes(params[:university_search])
        format.html { redirect_to @university_search, notice: 'University search was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @university_search.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @university_search = UniversitySearch.find(params[:id])
    @university_search.destroy

    respond_to do |format|
      format.html { redirect_to university_searches_url }
      format.json { head :ok }
    end
  end

  def about_us

  end

  def about_site
    
  end
end
