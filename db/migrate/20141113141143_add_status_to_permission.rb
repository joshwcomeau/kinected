class AddStatusToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :status, :integer
  end
end
