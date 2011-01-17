class AchievementObserver < ActiveRecord::Observer
  def after_create( achievement )
    feed_item = FeedItem.create( :feed_type => :user_forged_achievement )
    add_to_feeds( feed_item, achievement )
  end

    private

    # add the feed item to its appropriate feeds (add_feed_item takes care of duplciates)
    def add_to_feeds( feed_item, achievement )
      feed_item.user = membership.user
      feed_item.referenced_model = membership.group
      feed_item.save!
      membership.group.feed.add_feed_item( feed_item )
      membership.user.feed.add_feed_item( feed_item )
      membership.group.users.each { |user| user.feed.add_feed_item( feed_item ) } # add to each feed item for members of the group
    end
end

