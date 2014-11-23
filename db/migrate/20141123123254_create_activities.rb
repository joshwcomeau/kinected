class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string      :action
      t.boolean     :seen
      t.integer     :trackable_id
      t.string      :trackable_type
      t.belongs_to  :user
      t.timestamps
    end
  end
end
