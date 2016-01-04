class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:secret, :my_task]

  def secret
    # Test google-map javascript remove in 3 days : 1.5.16
    @tasks = Task.all
  end

end
