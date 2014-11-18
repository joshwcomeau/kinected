class AddCaptionToProfilePhoto < ActiveRecord::Migration
  def change
    add_column :profile_photos, :caption, :string
  end
end
