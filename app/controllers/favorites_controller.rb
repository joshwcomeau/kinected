class FavoritesController < ApplicationController
  load_and_authorize_resource

  def create
    begin
      # Let's make sure this isn't a duplicate
      @pre_existing_fav = Favorite.find_by(user_id: @favorite.user_id, target_user_id: @favorite.target_user_id)
      raise "Duplicate Favorite" if @pre_existing_fav

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
    params.require(:favorite).permit(:user_id, :target_user_id)
  end
end
