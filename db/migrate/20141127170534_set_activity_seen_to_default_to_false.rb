class SetActivitySeenToDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :activities, :seen, :boolean, default: false
  end
end
