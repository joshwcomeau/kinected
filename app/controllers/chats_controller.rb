class ChatsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @other_user = User.find(params[:id])

    # Check if I've blocked or never accepted them
    my_perm = Permission.find_by({
      user_id:        current_user.id,
      target_user_id: @other_user.id,
      status:         1
    })

    # Check if they've blocked or never accepted me
    their_perm = Permission.find_by({
      user_id:        @other_user.id,
      target_user_id: current_user.id,
      status:         1
    })

    if my_perm && !their_perm
      redirect_to root_url, alert: "Sorry, it appears as though this user does not wish to chat with you at this time."
    elsif their_perm && !my_perm
      # Shouldn't be possible to get to this branch unless they type in the ID in the URL.
      redirect_to root_url, alert: "I've blocked this user. To unblock them, find their message in the Messages page and click 'unblock'"
    elsif !my_perm && !their_perm
      redirect_to root_url, alert: "You are not authorized to view this page."
    end

  end
end
