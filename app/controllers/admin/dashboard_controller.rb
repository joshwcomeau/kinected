class Admin::DashboardController < Admin::ApplicationController
  def index
    @daters = User.daters
    @paid_daters = User.paying.daters
    @trial_daters = User.free_trial.daters
    @concierges = User.concierges
    render layout: "application_admin"
  end
end
