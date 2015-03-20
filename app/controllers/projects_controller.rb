class ProjectsController < ApplicationController
  # before_filter :require_login, :only => :new

  def index
    if params[:search]
      #Project.where("name ILIKE ?", "%#{params[:search]}%")
      @projects = Project.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else     
      @projects = Project.all.page params[:page]
    end

    # @projects = @projects.page params[:page]

    respond_to do |format|
      format.html do
        if request.xhr?
          render @projects
        end
      end
      format.js
    end
  end

  def new
    @project = Project.new
    @project.positions.build
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user

    if @project.save
      redirect_to projects_path
    else
      flash.now[:alert] = "Project could not be created."
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attribute
      redirect_to project_path(@project)
    else
      flash.now[:alert] = "Project could not be updated."
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was destroyed."
  end

  private
  def project_params
    params.require(:project).permit(
      :name, 
      :description, 
      :status, 
      :location,
      positions_attributes: [
        :description,
        :role_id,
        :_destroy
      ],
      image_attributes: [
        :picture
      ]
    )
  end
end
