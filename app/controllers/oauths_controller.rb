class OauthsController < ApplicationController
	skip_before_filter :require_login

  def oauth
  	login_at(params[:provider])
  end

  def callback
   	provider = params[:provider]
  	if @user = login_from(provider)
  		redirect_to edit_user_path(@user)
  	else
  		begin
  			user_profile = RestClient.get('https://api.linkedin.com/v1/people/~?format=json')
  			binding.pry
  			# @user = create_from(provider)
  			# reset_session
  			# auto_login(@user)
  			# redirect_to user_path(@user)
  		rescue
  			redirect_to new_user_path, alert: "Sign up with LinkedIn failed."
  		end
  	end
  end

  # def create_from(provider_name, &block)
  #   sorcery_fetch_user_hash provider_name
  #   config = user_class.sorcery_config  
  #   p attrs: @user_hash

  #   attrs = user_attrs(@provider.user_info_mapping, @user_hash)
  #   @user = user_class.create_from_provider(provider_name, @user_hash[:uid], attrs, &block)
  # end

  # private
  # def auth_params
  # 	params.permit(:code, :provider, :oauth_token, :oauth_verifier)
  # end
end
