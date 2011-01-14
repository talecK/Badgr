class Feed < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_many :feed_items, :through => :feed_subscriptions
  has_many :feed_subscriptions

  # def find_feed_item( values = {} )
   # self.feed_items.to_ary.find { |item| ( item.source == values[:source] ) }
  # end

  def add_creation_feed_item( creator, group )
    feed_item = FeedItem.create!( :feed_type => :user_built_hub, :user => creator )
    feed_item.user = creator
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.feed_subscriptions.create( :feed_id => self.id, :feed_item_id => feed_item.id )
    creator.feed.feed_subscriptions.create( :feed_id => creator.feed.id, :feed_item_id => feed_item.id )

    group.save!
    creator.save!
  end

  def add_user_joined_feed_item( user, group )
    feed_item = FeedItem.create!( :feed_type => :user_joined_hub, :user => user )
    feed_item.user = user
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.feed_subscriptions.create( :feed_id => self.id, :feed_item_id => feed_item.id )
    user.feed.feed_subscriptions.create( :feed_id => user.feed.id, :feed_item_id => feed_item.id )

    group.save!
    user.save!
  end

  def add_user_left_feed_item( user, group )
    feed_item = FeedItem.create!( :feed_type => :user_left_hub, :user => user )
    feed_item.user = user
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.feed_subscriptions.create( :feed_id => self.id, :feed_item_id => feed_item.id )
    user.feed.feed_subscriptions.create( :feed_id => user.feed.id, :feed_item_id => feed_item.id )

    group.save!
    user.save!
  end

end

