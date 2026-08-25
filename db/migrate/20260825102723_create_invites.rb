class CreateInvites < ActiveRecord::Migration[8.1]
  def change
    create_table :invites do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true

      t.timestamps
    end
  end
end
