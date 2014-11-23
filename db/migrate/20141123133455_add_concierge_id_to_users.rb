class AddConciergeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :concierge_id, :integer
  end
end
