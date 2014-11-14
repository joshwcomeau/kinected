class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters
  def index
    @users = current_user.get_valid_matches
  end

  # GET /daters/:id
  def show
    @message = Message.new
  end

  
end
