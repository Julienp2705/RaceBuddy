class CreateBuddyRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :buddy_ratings do |t|
      t.timestamps
    end
  end
end
