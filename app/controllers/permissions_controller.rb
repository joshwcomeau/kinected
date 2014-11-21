class PermissionsController < ApplicationController
  load_and_authorize_resource
  
  # POST /permissions
  def create
    respond_to do |format|
      # ATM, all 'allowed' requests are done via html, and all 'block' requests are done through AJAX and JSON.
      format.html do
        if @permission.save
          flash[:notice] = I18n.t "flash_messages.permissions.create.success"
        else
          flash[:error] = I18n.t "flash_messages.permissions.create.failure"
        end
        redirect_to messages_path
      end

      format.json do 
        
        render json: { result: @permission.save }
      end
    end
  end

  private
  def permission_params
    params.require(:permission).permit(:user_id, :target_user_id, :status, :message_id)
  end
end
