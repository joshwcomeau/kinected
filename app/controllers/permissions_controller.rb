class PermissionsController < ApplicationController
  load_and_authorize_resource
  # POST /permissions
  def create

  end

  private
  def permission_params
    params.require(:permission).permit(:user_id, :target_user_id, :status)
  end
end
