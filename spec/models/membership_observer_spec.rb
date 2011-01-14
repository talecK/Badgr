require 'spec_helper'

describe MembershipObserver do
  before (:each) do
    @group = Factory(:group)
    @group.save!
    @user = Factory(:user)
    @user.save!
  end

  it "should put an item in the user feed when a new membership is created (user joins a hub)" do
    @group.add_user(@user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                  :user_id => @user.id, :feed_type => :user_joined_hub
                                ).count
    feed_item_count.should == 1
  end

end

