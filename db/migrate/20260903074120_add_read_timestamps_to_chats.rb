class AddReadTimestampsToChats < ActiveRecord::Migration[8.1]
  def change
    add_column :chats, :inviter_read_at, :datetime
    add_column :chats, :invitee_read_at, :datetime
  end
end
