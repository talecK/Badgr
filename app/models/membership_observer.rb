class MembershipObserver < ActiveRecord::Observer
  def after_create( membership )
    feed_type = membership.group_creator? ? :user_built_hub : :user_joined_hub
    feed_item = FeedItem.create( :feed_type => feed_type )
    add_to_feeds( feed_item, membership )
  end

  def after_destroy( membership )
    feed_type = membership.banned_by.nil? ? :user_left_hub : :user_banned_from_hub
    feed_item = FeedItem.create( :feed_type => feed_type )
    add_to_feeds( feed_item, membership )
  end


  private

    # add the feed item to its appropriate feeds (add_feed_item takes care of duplciates)
    def add_to_feeds( feed_item, membership )
      feed_item.user = membership.user
      feed_item.referenced_model = membership.group
      feed_item.save!
      membership.group.feed.add_feed_item( feed_item )
      membership.user.feed.add_feed_item( feed_item )
      membership.group.users.each { |user| user.feed.add_feed_item( feed_item ) } # add to each feed item for members of the group
    end
end

