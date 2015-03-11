class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)

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
    params.require(:project).permit(:name, :description, :status, :location)
  end
end