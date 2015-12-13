class RegistrationsController < Devise::RegistrationsController

  # params[:user].permit(:name, :email, :password)

  protected
# https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
