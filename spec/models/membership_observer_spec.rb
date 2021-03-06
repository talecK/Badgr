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

  it "should put an item in the user feed when a new hub is built" do
    @group.add_creator(@user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => @user.id, :feed_type => :user_built_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an item in the user feed when a user leaves a hub" do
    @group.add_user(@user)
    @group.remove_user(@user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => @user.id, :feed_type => :user_left_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an item in the feed for fellow group members when a user joins / leaves a hub" do
    user2 = Factory(:user, :email => Factory.next(:email))
    user2.save!
    @group.add_creator(@user)
    @group.add_user(user2)
    feed_item_count = @user.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => user2.id, :feed_type => :user_joined_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an item in the group feed for when a member is banned" do
    user2 = Factory(:user, :email => Factory.next(:email))
    user2.save!
    @group.add_user( @user )
    @group.remove_user(@user, :via_ban_by => user2 )
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group,
                                                    :user_id => @user, :feed_type => :user_banned_from_hub
                                                  ).count
    feed_item_count.should == 1
  end
end

