class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string      :feed_type

      t.references  :referenced_model, :polymorphic => true
      t.belongs_to  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :feed_items
  end
end

