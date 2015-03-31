class ProjectsController < ApplicationController
  before_filter :require_login, :only => :new

  def home

    @projects = if params[:search]
      Project.where("name ILIKE ?", "%#{params[:search]}%").order('projects.created_at DESC').page(params[:page]).per(3)
    else     
      Project.order('projects.created_at DESC').page(params[:page])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @projects = if params[:search]
      Project.where("name ILIKE ?", "%#{params[:search]}%").order('projects.created_at DESC').page(params[:page])
    elsif params[:project_filter]
      role = Role.find(params[:project_filter])
      # role_positions = role.positions
      # projects = role_positions.map { |position| Project.find(position.project_id) }
      Project.where(roles: role).page(params[:page])
    else     
      Project.order('projects.created_at DESC').page(params[:page])
    end

    # @projects = filter & search

    respond_to do |format|
      format.html
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
    if @project.update_attributes(project_params)
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
      :github_repo,
      positions_attributes: [
        :description,
        :role_id,
        :id,
        :_destroy
      ],
      image_attributes: [
        :picture
      ]
    )
  end
end
