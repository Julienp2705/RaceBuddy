class CreateRaces < ActiveRecord::Migration[8.1]
  def change
    create_table :races do |t|
      t.string :name
      t.string :url
      t.float :distance

      t.timestamps
    end
  end
end
