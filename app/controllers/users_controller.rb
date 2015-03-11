class UsersController < ApplicationController

	def new
	end

	def create
	end

	def show
	end


	private
	def user_params
		params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :bio, :location)
	end

end
