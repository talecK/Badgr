require 'spec_helper'

describe FriendshipObserver do
  before (:each) do
    @user = Factory(:user)
	@friend = Factory(:user, :email => "valid_friend@valid.com", :name => "Some Friend")
    @user.save!
	@friend.save!
	@friendship = @user.friendships.build(:friend_id => @friend.id, :pending => true)
	@friendship.save!
  end

  it "should put an item in the user's feed when a new friendship is created" do
    @friendship.update_attributes(:pending => false)
    feed_item_count = @user.feed.feed_items.where( :referenced_model_id => @friend.id,
                                                    :user_id => @user.id, :feed_type => :user_added_friend
                                                  ).count
    feed_item_count.should == 1
  end
  
  it "should put an item in the friend's feed when a new friendship is created" do
    @friendship.update_attributes(:pending => false)
    feed_item_count = @friend.feed.feed_items.where( :referenced_model_id => @user.id,
                                                    :user_id => @friend.id, :feed_type => :user_added_friend
                                                  ).count
    feed_item_count.should == 1
  end
 
end

