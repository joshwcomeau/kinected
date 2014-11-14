class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters/:id
  def show
    @message = Message.new
  end

  # GET /browse
  # Essentially 'show', but for a filtered user
  def browse
    @user = current_user.find_next_user()
    redirect_to dater_path(@user)
  end

end
