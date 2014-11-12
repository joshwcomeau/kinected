class AddLotsOfIndexesForForeignKeys < ActiveRecord::Migration
  def change
    add_index :permissions, :user_id
    add_index :permissions, :target_user_id

    add_index :messages, :user_id
    add_index :messages, :recipient_id
  end
end
