class PermissionsController < ApplicationController
  load_and_authorize_resource
  
  # POST /permissions
  def create
    if @permission.save
      flash[:notice] = I18n.t "flash_messages.permissions.create.success"
    else
      flash[:error] = I18n.t "flash_messages.permissions.create.failure"
    end
    redirect_to messages_path
  end

  private
  def permission_params
    params.require(:permission).permit(:user_id, :target_user_id, :status, :message_id)
  end
end
