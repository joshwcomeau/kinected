class SwitchStatFieldsOnUserFromEnumToString < ActiveRecord::Migration
  def change
    change_column :users, :body_type, :string
    change_column :users, :smoking, :string
    change_column :users, :drinking, :string
    change_column :users, :religion, :string
    change_column :users, :education, :string
    change_column :users, :work_industry, :string
    change_column :users, :relationship_status, :string
    change_column :users, :wants_kids, :string
  end
end
