require 'spec_helper'

describe FeedItemsHelper do
  before (:each) do
    @group = Factory(:group)
    @group.save!
    @user = Factory(:user)
    @user.save!
  end

  it "should convert an entry in the user feed (using first person text) for when a user creates a group" do
    @group.add_creator(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_built_hub, :referenced_model_id => @group.id ).first
    feed_item_to_text( feed_item, :first_person => true ).should == "You built the #{@group.name} Hub"
  end

  it "should convert an entry in the user feed (using first person text) for when a user leaves a group" do
    @group.add_user(@user)
    @group.remove_user(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_left_hub, :referenced_model_id => @group.id ).first
    feed_item_to_text( feed_item, :first_person => true ).should == "You left the #{@group.name} Hub"
  end

  it "should convert an entry in the user feed (using first person text) for when a user joins a group" do
    @group.add_user(@user)
    feed_item = @user.feed.feed_items.where( :user_id => @user.id, :feed_type => :user_joined_hub, :referenced_model_id => @group.id ).first
    feed_item_to_text( feed_item, :first_person => true ).should == "You became a member of the #{@group.name} Hub"
  end
end

