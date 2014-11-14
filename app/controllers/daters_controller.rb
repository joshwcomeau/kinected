class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters/:id
  def show
    @message = Message.new
  end

  # GET /browse
  # Essentially 'show', but for a filtered user
  def browse
    @user = User.find_next_user(0)
    redirect_to dater_path(@user)
  end

end
