class PositionRequestsController < ApplicationController
  before_filter :require_login, :only => :create

  def new
    @positionrequest = project.position_requests.new
  end

  def create 
    @position_request = project.position_requests.build(position_request_params)
    @position_request.applicant_id = current_user.id
    PositionMailer.position_request_mail(project.owner, project).deliver_now
    if @position_request.save
      redirect_to project_path(@project)
    end
  end

  def accept
    position_request.accept!
    redirect_to project_path(project)
  end

  def reject
    position_request.reject!
    redirect_to project_path(project)
  end

  private
  def position_request_params
    params.require(:position_request).permit(:position_id, :project_id)
  end

  def position_request
    @position_request ||= project.position_requests.find(params[:id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
