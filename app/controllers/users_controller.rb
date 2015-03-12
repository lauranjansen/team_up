class UsersController < ApplicationController
	before_filter :load_role

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params.except(:roles_attributes))

		user_params[:roles_attributes].each do |id, role_attrs|
			role = Role.find_by(id: role_attrs['id'])
			@user.roles << role
		end

		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "Welcome to Team Up!"
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
		@owned_projects = Project.where("owner_id = ?", @user.id)
	end

	private
	def user_params
		params.require(:user).permit(
			:email,
			:first_name,
			:last_name,
			:bio,
			:location,
			:password,
			:password_confirmation,
			image_attributes: [
				:picture
			],
			skills_attributes: [
				:id,
				:name,
				:done,
				:_destroy
			],
			roles_attributes: [
				:id,
				:name,
				:done,
				:_destroy
			])
	end

	def load_role
		@roles = Role.all
	end
end
