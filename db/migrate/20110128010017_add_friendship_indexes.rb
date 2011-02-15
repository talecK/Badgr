class AddFriendshipIndexes < ActiveRecord::Migration
  def self.up
	add_index :friendships, :user_id
	add_index :friendships, :friend_id
	add_index :friendships, [:user_id, :friend_id], :unique => true
  end

  def self.down
	remove_index :friendships, :user_id
	remove_index :friendships, :friend_id
	remove_index :friendships, [:user_id, :friend_id]
  end
end
