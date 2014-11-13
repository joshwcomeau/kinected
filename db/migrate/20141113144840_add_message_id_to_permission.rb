class AddMessageIdToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :message_id, :integer
  end
end
