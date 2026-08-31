class AddRaceDateToRaces < ActiveRecord::Migration[8.1]
  def change
    add_column :races, :race_date, :date
  end
end
