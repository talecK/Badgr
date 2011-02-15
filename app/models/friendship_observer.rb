class FriendshipObserver < ActiveRecord::Observer
  def after_update( friendship )
    feed_type = :user_added_friend
    feed_item = FeedItem.create( :feed_type => feed_type )
    add_to_user_feeds( feed_item, friendship )
	feed_item = FeedItem.create( :feed_type => feed_type )
    add_to_friend_feeds( feed_item, friendship )
  end

  private

    # add the feed item to its appropriate feeds (add_feed_item takes care of duplciates)
    def add_to_user_feeds( feed_item, friendship )
      feed_item.user = friendship.user
      feed_item.referenced_model = friendship.friend
      feed_item.save!
      friendship.user.feed.add_feed_item( feed_item )
    end
	
	def add_to_friend_feeds( feed_item, friendship )
      feed_item.user = friendship.friend
      feed_item.referenced_model = friendship.user
      feed_item.save!
      friendship.friend.feed.add_feed_item( feed_item )
    end
end

