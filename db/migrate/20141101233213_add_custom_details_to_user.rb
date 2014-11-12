class AddCustomDetailsToUser < ActiveRecord::Migration
  def change
    # Required fields
    add_column :users, :birthdate, :date
    add_column :users, :country, :string
    add_column :users, :postal_code, :string

    # Role (dater, concierge, admin), Status (pending, active, banned) and Sex are stored as ints, with enum
    add_column :users, :sex, :integer, default: 0
    add_column :users, :status, :integer, default: 0
    add_column :users, :role, :integer

    # Geocoded lat/long
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float

    # Optional extras
    add_column :users, :self_summary, :text
    add_column :users, :height, :integer      # stored in cm
    add_column :users, :income, :integer
    add_column :users, :num_of_kids, :integer

    # These optional fields are also stored as enums, so it can be changed easily
    add_column :users, :body_type, :integer  
    add_column :users, :smoking, :integer
    add_column :users, :drinking, :integer
    add_column :users, :religion, :integer
    add_column :users, :education, :integer
    add_column :users, :work_industry, :integer
    add_column :users, :wants_kids, :integer
    add_column :users, :relationship_status, :integer
  end
end
