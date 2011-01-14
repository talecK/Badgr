class Feed < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_many :feed_items, :through => :feed_subscriptions
  has_many :feed_subscriptions

  # def find_feed_item( values = {} )
   # self.feed_items.to_ary.find { |item| ( item.source == values[:source] ) }
  # end

  def add_creation_feed_item( creator, group )
    feed_item = FeedItem.create!( :feed_type => :user_built_hub )
    feed_item.user = creator
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.add_feed_item( feed_item )
    creator.feed.add_feed_item( feed_item )
  end

  def add_user_joined_feed_item( user, group )
    feed_item = FeedItem.create!( :feed_type => :user_joined_hub )
    feed_item.user = user
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.add_feed_item( feed_item )
    user.feed.add_feed_item( feed_item )
  end

  def add_user_left_feed_item( user, group )
    feed_item = FeedItem.create!( :feed_type => :user_left_hub )
    feed_item.user = user
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.add_feed_item( feed_item )
    user.feed.add_feed_item( feed_item )
  end

  # adds a feed item reference, if the feed doesn't already reference it
  def add_feed_item(item)
    unless( self.feed_items.exists?(item.id) )
     return self.feed_subscriptions.create(:feed_item_id => item.id)
    else
     return false
    end
  end

end

