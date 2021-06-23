class CreateFriendLists < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_lists do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
