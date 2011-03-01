class UserAchievementObserver < ActiveRecord::Observer

  def after_save( user_achievement )
    if( user_achievement.ordinal_to_state == :Pending )
      feed_item = FeedItem.create( :feed_type => :user_requested_achievement )
      feed_item.user = user_achievement.user
      feed_item.referenced_model = user_achievement
      feed_item.make_private!
      feed_item.save!

      user_achievement.user.feed.add_feed_item( feed_item )

    elsif( user_achievement.ordinal_to_state == :Denied )
      feed_item = FeedItem.create( :feed_type => :user_denied_achievement )
      feed_item.user = user_achievement.user
      feed_item.referenced_model = user_achievement
      feed_item.make_private!
      feed_item.save!

      user_achievement.user.feed.add_feed_item( feed_item )

    elsif( user_achievement.ordinal_to_state == :Awarded )
      feed_item = FeedItem.create( :feed_type => :user_earned_achievement )
      feed_item.user = user_achievement.user
      feed_item.referenced_model = user_achievement
      feed_item.save!

      user_achievement.achievement.group.feed.add_feed_item( feed_item )
      user_achievement.achievement.group.users.each { |user| user.feed.add_feed_item( feed_item ) } # add to each feed item for members of the group
    else
      nil.save
    end
  end

  # add the feed item to its appropriate feeds (add_feed_item takes care of duplciates)
  def add_to_feeds( feed_item, user_achievement )
    feed_item.user = user_achievement.user
    feed_item.referenced_model = user_achievement
    feed_item.save!

    user_achievement.achievement.group.feed.add_feed_item( feed_item )
    user_achievement.achievement.group.users.each { |user| user.feed.add_feed_item( feed_item ) } # add to each feed item for members of the group
  end
end

