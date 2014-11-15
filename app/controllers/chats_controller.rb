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
      redirect_to root_url, alert: I18n.t("flash_messages.chats.show.missing_their_permission")
    elsif their_perm && !my_perm
      # Shouldn't be possible to get to this branch unless they type in the ID in the URL.
      redirect_to root_url, alert: I18n.t("flash_messages.chats.show.missing_my_permission")
    elsif !my_perm && !their_perm
      redirect_to root_url, alert: I18n.t("flash_messages.chats.show.missing_both_permissions")
    end
  end
end
