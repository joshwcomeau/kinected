class ChangeEthnicitiesToHabtm < ActiveRecord::Migration
  def change
    create_table :ethnicities_users, id: false do |t|
      t.belongs_to :ethnicity
      t.belongs_to :user
    end

    remove_column :ethnicities, :user_id, :integer
  end
end
