class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:secret, :my_task] #syntax may baulk
end
