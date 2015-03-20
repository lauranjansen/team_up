class UsersController < ApplicationController
	before_filter :load_role
	skip_before_filter :require_login

	def index
    if params[:search]
      #Project.where("name ILIKE ?", "%#{params[:search]}%")
      @users = User.where("(first_name || last_name) ILIKE ?", "%#{params[:search]}%").limit(200)
    else     
      @users = User.all.page params[:page]
    end

    respond_to do |format|
      format.html do
        if request.xhr?
          render @users
        end
      end
      format.js
    end
  end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params.except(:roles_attributes))
		
		if user_params[:roles_attributes]
			user_params[:roles_attributes].each do |id, role_attrs|
				role = Role.find_by(id: role_attrs['id'])
				@user.roles << role
			end
		end

		if @user.save
			LoginMailer.welcome_mail(@user).deliver_now
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "Welcome to Team Up!"
		else
			render :new
		end
	end

	def import
		@user_profile = Linkedin::Profile.get_profile(import_params)
		if @user_profile
			respond_to do |format|
				format.html do
					raise 'Requires JavaScript.'
				end
	      format.js
	      puts "!!!!!"
	    end
	  else
	  	render 'layouts/error.js'
	  end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			redirect_to user_path(@user)
		else
			render :edit
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
			]
		)
	end

	def load_role
		@roles = Role.all
	end

	def import_params
		params.require(:linkedin_url)
	end
end
