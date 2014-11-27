class DatersController < ApplicationController
  load_and_authorize_resource class: User
  # skip_before_action :verify_authenticity_token
  
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
        @dater = @dater.get_full_match_data(current_user)
        @message = Message.new
        # Go with the implied render
      end
      format.json do
        render json: @dater.get_full_match_data(current_user)
      end
    end
  end

  # PATCH /daters/:id
  def update
    render json: {result: !!@dater.update(dater_params)}
  end

  def edit
    
  end

  private

  def dater_params
    params.require(:dater).permit(:self_summary, answers_attributes: [:id, :body])
  end
  
end
