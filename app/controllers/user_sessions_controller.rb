class UserSessionsController < ApplicationController

	def new
    @user = User.new
  end

  def create
    session[:return_to] ||= request.referer
    if @user = login(params[:email], params[:password])
    redirect_to session.delete(:return_to), notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end
