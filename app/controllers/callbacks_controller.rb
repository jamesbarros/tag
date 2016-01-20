class CallbacksController < Devise::OmniauthCallbacksController



  # from : http://www.munocreative.com/nerd-notes/winvoice
  # @user = current_user didn't work in the past, may work if we login for prior to stripe OAuth
  def stripe_connect
      @user = current_user
      if @user.update_attributes({
        provider: request.env["omniauth.auth"].provider,
        stripe_provider: request.env["omniauth.auth"].provider,
        uid: request.env["omniauth.auth"].uid,
        stripe_uid: request.env["omniauth.auth"].uid,
        stripe_access_token: request.env["omniauth.auth"].credentials.token,
        stripe_publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
      })
        # anything else you need to do in response..
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
      else
        session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
  end



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
    # http://travisjeffery.com/b/2012/04/rendering-errors-in-json-with-rails/
    render :json => { :errors => @user.errors.full_message }, status: 422

    # http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin/
    # format.json { render json: @user.errors, status: :unprocessable_entity }

    # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
    # status: :unprocessable_entity == status: 422

    # render @user.to_json # SO suggestion that kind of worked before
    # redirect_to root_path # commented out for debugging
  end

end
