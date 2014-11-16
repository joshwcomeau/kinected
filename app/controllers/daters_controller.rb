class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters
  def index
    # Let's overwrite the default loaded daters
    @daters = current_user.get_valid_matches
    @dater = User.first
    @message = Message.new
  end

  # GET /daters/:id
  def show
    @daters = nil
    @message = Message.new
  end

  
end
