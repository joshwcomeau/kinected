class FavoritesController < ApplicationController
  load_and_authorize_resource

  def create
    begin
      @favorite.save
      render json: { result: @favorite }
    rescue
      render json: { result: false }
    end
  end

  def destroy
    begin
      @favorite.destroy
      render json: { result: @favorite.persisted? }
    rescue
      render json: { result: false }
    end
  end


  private

  def favorite_params
    params.require(:favorite).permit(:id, :user_id, :target_user_id)
  end
end
