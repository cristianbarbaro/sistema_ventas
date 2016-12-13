class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      flash[:success] = 'El usuario ha iniciado sesión correctamente.'
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:alert] = 'El email ya existe en la base de datos para otro usuario.'
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:success] = 'El usuario ha iniciado sesión correctamente.'
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      flash[:alert] = 'El email ya existe en la base de datos para otro usuario.'
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
