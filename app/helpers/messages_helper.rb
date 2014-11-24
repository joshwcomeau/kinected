module MessagesHelper
  def outbound?(m)
    current_user === m.user
  end

  def inbound?(m)
    current_user === m.recipient
  end

  def unread?(m)
    m.queued? || m.sent?
  end

  def outbound_and_unread?(m)
    outbound?(m) && unread?(m)
  end

  def direction(m)
    inbound?(m) ? "received" : "sent"
  end

  def get_other_user(m)
    return m.recipient if m.user == current_user
    return m.user if m.recipient == current_user
  end

end
