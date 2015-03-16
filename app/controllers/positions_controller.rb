class PositionsController < ApplicationController
  before_filter :load_project

  def new
  end

  def create
    @position = @project.positions.build(position_params)

    if @position.save
      notice: 'This position was saved. FUCK YEAH CANADA!'
    else
      flash.now[:alert] = "fuck off, that isn't a real position!"
      render 'projects/new'
    end


  end

  def edit
  end

  def update
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
  end

  private
  def position_params
    params.require(:position).permit(:description, :role_id, :_destroy)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end

end
