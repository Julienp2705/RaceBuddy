class CreateTargets < ActiveRecord::Migration[8.1]
  def change
    create_table :targets do |t|
      t.integer :target_hour
      t.integer :target_minute
      t.references :race, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
