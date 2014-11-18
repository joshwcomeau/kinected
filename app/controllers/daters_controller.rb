class DatersController < ApplicationController
  load_and_authorize_resource class: User
  
  # GET /daters
  def index
    # Let's overwrite the default loaded daters with an array of hashes that Angular can use, without unneeded overhead.
    @daters = current_user.get_list_of_matches
    @dater = current_user.get_first_match
    @message = Message.new
  end

  # GET /daters/:id
  def show
    respond_to do |format|
      format.html do
        @daters = nil
        @dater  = User.find(params[:id]).get_full_match_data
        @message = Message.new
        # Go with the implied render
      end
      format.json do
        render json: User.find(params[:id]).get_full_match_data
      end
    end
  end

  
end
