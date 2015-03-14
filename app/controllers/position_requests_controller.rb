class PositionRequestsController < ApplicationController
  before_filter :load_project

  def new
    @positionrequest = PositionRequest.new
  end

  def create 
    @position_request = @project.position_requests.build(position_request_params)
    @position_request.applicant_id = current_user
    if @position_request.save
      redirect_to projects_path
    end
  end

  private
  def position_request_params
    params.require(:position_request).permit(:position_id, :project_id)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
