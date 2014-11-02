class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.belongs_to :user
      t.string :name
      t.timestamps
    end
  end
end
