class PositionRequestsController < ApplicationController

    def new
    @positionrequest = PositionRequest.new
  end

  def create 
    @positionrequest = PositionRequest.new(positionrequest_params)
    if save
      redirect_to projects_path
    end
  end

  private
  def positionrequest_params
    params.require(:positionrequest).permit(:user_id, :position_id)
  end
end
