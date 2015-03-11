class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "Welcome to Team Up!"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
		@owned_projects = Project.where("owner_id = ?", current_user.id)
	end

	private
	def user_params
		params.require(:user).permit(:email, :first_name, :last_name, :bio, :location, :password, :password_confirmation)
	end

end
