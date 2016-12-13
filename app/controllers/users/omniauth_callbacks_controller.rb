class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:success, :success, :kind => "Facebook") if is_navigational_format?
    else
      set_flash_message(:alert, :failure, :kind => "Facebook", :reason => "tal vez el mail ya está registrado") if is_navigational_format?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:success, :success, :kind => "Google") if is_navigational_format?
    else
      set_flash_message(:alert, :failure, :kind => "Facebook", :reason => "tal vez el mail ya está registrado.") if is_navigational_format?
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
