class AddUserAndBuddyAndRatingToBuddyRatings < ActiveRecord::Migration[8.1]
  def change
    remove_reference :buddy_ratings, :invite, null: false, foreign_key: true, index: { unique: true }

    add_reference :buddy_ratings, :user,  null: false, foreign_key: { to_table: :users }
    add_reference :buddy_ratings, :buddy, null: false, foreign_key: { to_table: :users }

  end
end
