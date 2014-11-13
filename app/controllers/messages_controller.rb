class MessagesController < ApplicationController
  load_and_authorize_resource
  
  # GET /messages
  def index
    @outbox = current_user.messages_sent.includes(:permissions)
    @inbox  = current_user.messages_received.includes(:permissions)
  end

  # GET /messages/:id
  def show; end

  # POST /messages
  def create; end

  # PATCH /messages/:id
  def update; end

  # DELETE /messages/:id
  def destroy; end
end
