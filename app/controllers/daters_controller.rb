class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters
  def index
    @users = current_user.get_valid_matches
    @first_dater = current_user.get_first_valid_match
    @message = Message.new
  end

  # GET /daters/:id
  def show
    @message = Message.new
  end

  
end
