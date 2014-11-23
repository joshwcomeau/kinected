class DashboardController < ApplicationController

  # GET /
  def index
    if current_user.concierge?
      redirect_to concierge_dashboard_index_path
    elsif current_user.admin?
      redirect_to admin_dashboard_index_path
    end
  end
end
