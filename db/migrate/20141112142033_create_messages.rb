class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.string  :body, limit: 200
      t.integer :status
      t.timestamps
    end
  end
end
