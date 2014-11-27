module ApplicationHelper
  def fetch_content(key, format=false)
    @string = "#{params[:controller]}.#{params[:action]}.#{key.to_s}"
    format == :raw ? raw(t(@string)) : t(@string)
  end

  def unread_messages?
    if current_user && current_user.dater?
      @unread_messages = current_user.activities.where(trackable_type: 'Message', action: 'create').count
      return @unread_messages > 0
    end
  end

  def get_chatting_partner_id
    if params[:controller] == 'chats' && params[:action] == 'show'
      return params[:id]
    else
      return nil
    end
  end
end
