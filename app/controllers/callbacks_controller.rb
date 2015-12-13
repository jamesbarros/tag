class CallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   sign_in_and_redirect @user
  # end
  # above works, below allows for Warden callbacks and event flash messages

  # This style of def specified by devise github
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end
