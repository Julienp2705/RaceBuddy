class AddUserAndBuddyAndRatingToBuddyRatings < ActiveRecord::Migration[8.1]
  def change
    add_column :buddy_ratings, :rating, :integer,  null: false

    add_reference :buddy_ratings, :user,  null: false, foreign_key: { to_table: :users }
    add_reference :buddy_ratings, :buddy, null: false, foreign_key: { to_table: :users }

  end
end

