require 'spec_helper'

describe FeedItem do
  before (:each) do
    @group = Factory(:group)
    @user = Factory(:user)
    @group.save!
    @user.save!
    @feed_item = @group.feed_items.create!(:feed_type => :user_joined_hub, :reference_id => @user.id )
  end

  it "should require a feed_type" do
    feed_item = @group.feed_items.build()
    feed_item.should_not be_valid
  end

  it "should require a feed_type that is defined" do
    feed_item = @group.feed_items.build(:feed_type => :some_invalid_type)
    feed_item.should_not be_valid
  end

  it "should be valid with a correct feed_type" do
    feed_item = @group.feed_items.build(:feed_type => :user_joined_hub)
    feed_item.should be_valid
  end

  it "should be able to return its source" do
    @feed_item.source.should == @group
  end

  it "should be able to return its reference" do
    @feed_item.reference.should == @user
  end
end

