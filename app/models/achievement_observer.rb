class AchievementObserver < ActiveRecord::Observer
  def after_create( achievement )
    feed_item = FeedItem.create( :feed_type => :user_forged_achievement )
    add_to_feeds( feed_item, achievement )
  end

    private

    # add the feed item to its appropriate feeds (add_feed_item takes care of duplciates)
    def add_to_feeds( feed_item, achievement )
      feed_item.user = achievement.creator
      feed_item.referenced_model = achievement
      feed_item.save!

      achievement.group.feed.add_feed_item( feed_item )
      # achievement.creator.feed.add_feed_item( feed_item )
      achievement.group.users.each { |user| user.feed.add_feed_item( feed_item ) } # add to each feed item for members of the group
    end
end

