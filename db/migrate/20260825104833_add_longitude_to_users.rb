class AddLongitudeToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :longitude, :float
  end
end
