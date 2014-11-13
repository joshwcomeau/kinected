class PermissionsController < ApplicationController
  load_and_authorize_resource
  # POST /permissions
  def create
    if @permission.save
      flash[:notice] = "Success! You can now chat with this user"
    else
      flash[:error] = "Sorry, we could not save your request."
    end
    redirect_to messages_path
  end

  private
  def permission_params
    params.require(:permission).permit(:user_id, :target_user_id, :status, :message_id)
  end
end
