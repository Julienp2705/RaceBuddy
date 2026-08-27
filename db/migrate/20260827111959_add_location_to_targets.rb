class AddLocationToTargets < ActiveRecord::Migration[8.1]
  def change
    add_column :targets, :address, :string
    add_column :targets, :latitude, :float
    add_column :targets, :longitude, :float
  end
end
