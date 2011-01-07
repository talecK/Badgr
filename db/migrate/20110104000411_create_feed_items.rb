class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string :feed_type
      t.string :reference_id

      t.references :source, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_items
  end
end

