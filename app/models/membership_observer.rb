class MembershipObserver < ActiveRecord::Base

  def after_create( membership )
    feed_item = FeedItem.create!( :feed_type => :user_joined_hub )
    feed_item.user = user
    feed_item.referenced_model = group
    feed_item.save!
    group.feed.add_feed_item( feed_item )
    user.feed.add_feed_item( feed_item )
  end

  private

    def find_user
      User.find
    end

    def find_group
    end


end

