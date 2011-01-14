require 'spec_helper'

describe Feed do
  before (:each) do
    @group = Factory(:group)
    @group.save!
    @user = Factory(:user)
    @user.save!
  end

  it "should put an entry (the only entry at this time) in the group feed for the groups creation" do
    @group.add_creator(@user)
    @group.feed.feed_items.first.text.should == "#{@user.name} built the #{@group.name} Hub"
  end

  it "should put an entry in the user feed (using first person text), when a user creates a group" do
    @group.add_creator(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_built_hub,  :referenced_model_id => @group.id ).first
    feed_item.text(:first_person => true).should == "You built the #{@group.name} Hub"
  end


  it "should put an entry in the group feed for when a user leaves the group" do
    @group.add_user(@user)
    @group.remove_user(@user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => @user.id, :feed_type => :user_left_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an entry in the user feed (using first person text), when a user leaves a group" do
    @group.add_user(@user)
    @group.remove_user(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_left_hub,  :referenced_model_id => @group.id ).first
    feed_item.text(:first_person => true).should == "You left the #{@group.name} Hub"
  end

  it "should put an entry in the feed for when a user joins the group" do
    @group.add_user(@user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => @user.id, :feed_type => :user_joined_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an entry in the user feed (using first person text), when a user joins a group" do
    @group.add_user(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_joined_hub,  :referenced_model_id => @group.id ).first
    feed_item.text(:first_person => true).should == "You became a member of the #{@group.name} Hub"
  end
end

