class Admin::UniversitiesController < Admin::AdminsController

  def index
    @universities = University.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @university }
    end
  end


  def show
    @university = University.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @university }
    end
  end

  
  def new
    @university = University.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @university }
    end
  end

  def edit
    @university = University.find(params[:id])
  end

 
  def create
    @university = University.new(params[:university])

    respond_to do |format|
      if @university.save
        format.html { redirect_to [:admin, @university], notice: 'University  was successfully created.' }
        format.json { render json: @university, status: :created, location: @university }
      else
        format.html { render action: "new" }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @university = University.find(params[:id])

    respond_to do |format|
      if @university.update_attributes(params[:university])
        format.html { redirect_to [:admin, @university], notice: 'University  was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @university = University.find(params[:id])
    @university.destroy

    respond_to do |format|
      format.html { redirect_to admin_universities_url }
      format.json { head :ok }
    end
  end
  
end
