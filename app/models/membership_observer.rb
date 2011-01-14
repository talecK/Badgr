class MembershipObserver < ActiveRecord::Observer
  def after_create( membership )
    feed_type = membership.group_creator? ? :user_built_hub : :user_joined_hub
    feed_item = FeedItem.create( :feed_type => feed_type )
    feed_item.user = membership.user
    feed_item.referenced_model = membership.group
    feed_item.save!
    membership.group.feed.add_feed_item( feed_item )
    membership.user.feed.add_feed_item( feed_item )
  end

  def after_destroy( membership )
    feed_item = FeedItem.create( :feed_type => :user_left_hub )
    feed_item.user = membership.user
    feed_item.referenced_model = membership.group
    feed_item.save!
    membership.group.feed.add_feed_item( feed_item )
    membership.user.feed.add_feed_item( feed_item )
  end
end

