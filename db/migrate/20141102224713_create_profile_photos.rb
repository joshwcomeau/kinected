class CreateProfilePhotos < ActiveRecord::Migration
  def change
    create_table :profile_photos do |t|
      t.string :photo_object
      t.boolean :primary, default: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
