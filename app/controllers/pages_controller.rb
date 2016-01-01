class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:secret, :my_task]

  def secret
    @tasks = Task.all
  end

end
