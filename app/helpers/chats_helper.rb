module ChatsHelper
  # Every chat instance needs a unique ID for its data to be stored in firebase.
  # We're going to concatenate their ordered IDs, bridged with an underscore.
  def get_room_id(user1, user2)
    user_ids = [user1.id, user2.id].sort
    user_ids.join("_")
  end
end
