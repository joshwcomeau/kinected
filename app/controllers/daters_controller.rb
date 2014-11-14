class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters/:id
  def show
    @message = Message.new
  end

end
