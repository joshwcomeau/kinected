class RenamePrimaryToPrimaryPhoto < ActiveRecord::Migration
  def change
    rename_column :profile_photos, :primary, :primary_photo
  end
end
