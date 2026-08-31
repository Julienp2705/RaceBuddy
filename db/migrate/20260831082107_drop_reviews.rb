class DropReviews < ActiveRecord::Migration[8.1]
  def change
    drop_table :reviews
  end
end
