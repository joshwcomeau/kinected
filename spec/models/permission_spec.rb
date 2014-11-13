# == Schema Information
#
# Table name: permissions
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#  status         :integer
#  message_id     :integer
#

require 'rails_helper'

RSpec.describe Permission, :type => :model do
  
end
