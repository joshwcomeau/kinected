class MessagesController < ApplicationController
  load_and_authorize_resource
  
  # GET /messages
  def index
    @messages = current_user.messages
    # @outbox = current_user.messages_sent.joins(:permissions).order("permissions.created_at DESC")
    # @inbox  = current_user.messages_received.joins(:permissions).order("permissions.created_at DESC")
  end

  # GET /messages/:id
  def show; end

  # POST /messages
  def create
    response = @message.save

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.json { render json: {result: response}  }
    end
  end

  # PATCH /messages/:id
  def update; end

  # DELETE /messages/:id
  def destroy; end


  private

  def message_params
    params.require(:message).permit(:user_id, :recipient_id, :body)
  end
end
