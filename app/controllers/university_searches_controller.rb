class UniversitySearchesController < ApplicationController
  # GET /university_searches
  # GET /university_searches.json
  def index
    @university_searches = UniversitySearch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @university_searches }
    end
  end

  # GET /university_searches/1
  # GET /university_searches/1.json
  def show
    @university_search = UniversitySearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @university_search }
    end
  end

  # GET /university_searches/new
  # GET /university_searches/new.json
  def new
    @university_search = UniversitySearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @university_search }
    end
  end

  # GET /university_searches/1/edit
  def edit
    @university_search = UniversitySearch.find(params[:id])
  end

  # POST /university_searches
  # POST /university_searches.json
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

  # PUT /university_searches/1
  # PUT /university_searches/1.json
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

  # DELETE /university_searches/1
  # DELETE /university_searches/1.json
  def destroy
    @university_search = UniversitySearch.find(params[:id])
    @university_search.destroy

    respond_to do |format|
      format.html { redirect_to university_searches_url }
      format.json { head :ok }
    end
  end
end
