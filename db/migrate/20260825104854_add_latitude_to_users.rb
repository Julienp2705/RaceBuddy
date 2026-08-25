class AddLatitudeToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :latitude, :float
  end
end
