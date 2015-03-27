class OauthsController < ApplicationController
  skip_before_filter :require_login
  before_filter :require_login, only: :destroy

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  # this is where all of the magic happens
  def callback
    # this will be set to 'github' when user is logging in via Github
    provider = auth_params[:provider]

    if @user = login_from(provider)
       session[:return_to] ||= request.referer
      # user has already linked their account with github

      flash[:notice] = "Logged in using #{provider.titleize}!"
      redirect_to session.delete(:return_to), notice: 'Login successful'
    else
      begin
        if provider == 'github'
          @user = create_from_github
          auto_login(@user)
          redirect_back_or_to edit_user_path(@user), notice: "Logged in from #{provider.titleize}!"
        end
      rescue
        redirect_back_or_to new_user_path, alert: "Failed to login from #{provider.titleize}!"        
      end
    end
  end

  # This is used to allow users to unlink their account from the oauth provider.
  #
  # In order to use this action you will need to include this route in your routes file:
  # delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth
  #
  # You will need to provide a 'provider' parameter to the action, create a link like this:
  # link_to 'unlink', delete_oauth_path('github'), method: :delete
  def destroy
    provider = params[:provider]

    authentication = current_user.authentications.find_by_provider(provider)
    if authentication.present?
      authentication.destroy
      flash[:notice] = "You have successfully unlinked your #{provider.titleize} account."
    else
      flash[:alert] = "You do not currently have a linked #{provider.titleize} account."
    end

    redirect_to root_path
  end

  private

  def link_account(provider)
    if @user = add_provider_to_user(provider)
      # If you want to store the user's Github login, which is required in order to interact with their Github account, uncomment the next line.
      # You will also need to add a 'github_login' string column to the users table.
      #
      # @user.update_attribute(:github_login, @user_hash[:user_info]['login'])
      flash[:notice] = "You have successfully linked your GitHub account."
    else
      flash[:alert] = "There was a problem linking your GitHub account."
    end
  end

  def create_from_github
    provider_name = 'github'
    sorcery_fetch_user_hash provider_name
    config = user_class.sorcery_config

    attrs = user_attrs(@provider.user_info_mapping, @user_hash)

    puts attrs.to_hash
    if attrs[:name]
      first_name = attrs[:name].split[0]
      last_name = attrs[:name].split[1]
      attrs[:first_name] = first_name
      attrs[:last_name] = last_name
      attrs.delete(:name)
    end

    user = user_class.create_from_provider(provider_name, @user_hash[:uid], attrs)

    return user
  end

  def auth_params
    params.permit(:code, :provider)
  end
end