class Admin::DatersController < Admin::ApplicationController
  load_and_authorize_resource class: User

  def index
    @paid_daters = User.paying.daters
    @trial_daters = User.free_trial.daters

  end
end
