class Concierge::DashboardController < ApplicationController
  def index
    if current_user.dater?
      redirect_to root_path
    end
  end
end
