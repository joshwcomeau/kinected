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

end
