require 'spec_helper'

describe FeedItem do
  before (:each) do
    @group = Factory(:group)
    @user = Factory(:user)
    @group.save!
    @user.save!
    @feed_item = @group.feed.feed_items.create(:feed_type => :user_joined_hub )
    @feed_item.user = @user
    @feed_item.referenced_model = @group
    @feed_item.save!
  end

  it "should require a feed_type" do
    feed_item = @group.feed.feed_items.build()
    feed_item.should_not be_valid
  end

  it "should require a feed_type that is defined" do
    feed_item = @group.feed.feed_items.build(:feed_type => :some_invalid_type)
    feed_item.should_not be_valid
  end

  it "should be valid with a correct feed_type" do
    feed_item = @group.feed.feed_items.build(:feed_type => :user_joined_hub)
    feed_item.should be_valid
  end

  it "should be able to return its reference model" do
    @feed_item.referenced_model.should == @group
  end

  it "should be able to return its user (that it references)" do
    @feed_item.user.should == @user
  end
end

