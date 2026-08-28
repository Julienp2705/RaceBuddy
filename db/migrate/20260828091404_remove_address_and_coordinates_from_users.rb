class RemoveAddressAndCoordinatesFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :address, :string
    remove_column :users, :latitude, :float
    remove_column :users, :longitude, :float
  end
end
