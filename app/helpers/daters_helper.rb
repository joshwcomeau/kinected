module DatersHelper
  def format_user_for_angular(user_object)
    user = user_object.attributes
    user[:primary_profile_photo]  = user_object.profile_photos.find_by(primary: true)
    user[:profile_photos]         = user_object.profile_photos.where.not(primary: true)

    user[:birthdate]    = time_in_ms(user_object.birthdate)
    user[:joined_num]   = time_in_ms(user_object.created_at)
    user[:joined_ago]   = time_ago_in_words(user_object.created_at)    
    user[:updated_num]  = time_in_ms(user_object.updated_at)
    user[:updated_ago]  = time_ago_in_words(user_object.updated_at)
    user[:ethnicities]  = user_object.ethnicities    

    if user_object.last_sign_in_at
      user[:last_seen_num]  = time_in_ms(user_object.last_sign_in_at)
      user[:last_seen_ago]  = time_ago_in_words(user_object.last_sign_in_at)
    end

    user
  end

  def format_user_list_for_angular(users)
    users.map do |u| 
      format_join = time_ago_in_words u.created_at
      vital_stats = {
        id:     u.id,
        thumb:  u.primary_profile_photo_blurred_thumb.url,
        joined: format_join
      }

      vital_stats[:last_seen] = time_ago_in_words(u.last_sign_in_at) if u.last_sign_in_at
      vital_stats
    end

  end

  def time_in_ms(time)
    # We need a time object, not a date object. Birthday is stored as a Date
    time = time.to_time if time.is_a? Date
    time.to_i * 1000
  end

end
