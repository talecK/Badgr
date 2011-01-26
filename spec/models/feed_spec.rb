require 'spec_helper'

describe Feed do
  before (:each) do
    @group = Factory(:group)
    @group.save!
    @user = Factory(:user)
    @user.save!

    @feed_item = FeedItem.create!( :feed_type => :user_joined_hub )
    @feed_item.user = @user
    @feed_item.referenced_model = @group
    @feed_item.save!
  end

  it "should be able to add a feed item by a function" do
    @group.feed.add_feed_item( @feed_item )
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                  :user_id => @user.id, :feed_type => :user_joined_hub
                                ).count
    feed_item_count.should == 1
  end

  it "shouldn't be able to add duplicate feed items" do
    @group.feed.add_feed_item( @feed_item )
    @group.feed.add_feed_item( @feed_item ).should == false
  end
end

