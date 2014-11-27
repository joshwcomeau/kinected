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

    @message.save if num_sent_today < Message::LIMIT

    if @message.persisted?
      track_activity @message, params[:action], @message.recipient 
      redirect_to root_path, notice: I18n.t("messages.create.sent")
    else
      redirect_to root_path, alert: I18n.t("messages.create.exceeded_limit")
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
