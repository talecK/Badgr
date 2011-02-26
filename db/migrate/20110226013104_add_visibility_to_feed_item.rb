class AddVisibilityToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :visibility, :integer, :default => 0
  end

  def self.down
    remove_column :feed_items, :visibility
  end
end

