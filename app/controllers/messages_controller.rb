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
    num_sent_today = current_user.messages_sent.where("created_at >= ?", Time.now.beginning_of_day).count

    if num_sent_today < Message::LIMIT
      response = { result: @message.save }
    else
      response = { result: false, message: I18n.t("messages.create.exceeded_limit") }
    end

    # Create activity notification!
    track_activity @message, params[:action], @message.recipient if @message.persisted?
    

    respond_to do |format|
      format.html { redirect_to messages_path }
      format.json { render json: response  }
    end
  end

  # PATCH /messages/:id
  def update
    if params[:message][:status] == "accept"
      response = @message.accepted!
    elsif params[:message][:status] == "reject"
      response = @message.rejected!
    end
    render json: { result: response }
  end

  # DELETE /messages/:id
  def destroy; end


  private

  def message_params
    params.require(:message).permit(:user_id, :recipient_id, :body)
  end

  def reject_params
    params.require(:message).permit(:status)
  end
end
