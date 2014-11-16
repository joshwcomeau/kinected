module DatersHelper
  def format_user_for_angular(user_object)
    user = user_object.attributes
    user[:primary_profile_photo] = user_object.profile_photos.find_by(primary: true)
    user[:profile_photos] = user_object.profile_photos.where.not(primary: true)
    user[:ethnicities]    = user_object.ethnicities
    user[:joined]         = time_ago_in_words user_object.created_at
    user[:last_seen]      = time_ago_in_words user_object.last_sign_in_at
    user
  end

  def format_user_list_for_angular(user_array)

  end

end
