require 'spec_helper'

describe Group do

  before (:each) do
    @group = Factory(:group)
  end

  it "should require a name" do
		no_name_group = Factory( :group,:name => "" )
		no_name_group.should_not be_valid
	end

  it "should require a unique name, case insensitive" do
    group1 = Factory( :group, :name => "duplicate_name" )
    group2 = Factory( :group, :name => "duplicate_name" )
    group1.save
    group2.save.should == false
  end

  it "should require a name less than 25 characters long" do
    group = Factory( :group, :name => "a" * 26)
    group.should_not be_valid
  end

  it "should be able to add users" do
    user = Factory( :user )
    user.save!
    @group.save!
    @group.add_user( user )
    returned_user = @group.users.find_by_id( user.id )
    user.should == returned_user
  end

  it "should be able to remove users" do
    user = Factory( :user )
    user.save!
    @group.save!
    @group.add_user( user )
    @group.remove_user( user )
    user.groups.find_by_id(@group).should == nil
  end

  it "should be able to check if a user is a member" do
    user = Factory(:user)
    user.save!
    @group.save!
    @group.add_user(user)
    @group.has_member?(user).should == true
  end

  it "should be able to check if a user is not a member" do
    user = Factory(:user)
    user.save!
    @group.save!
    @group.add_user(user)
    @group.remove_user(user)
    @group.has_member?(user).should == false
  end


  it "should put an entry (the only entry at this time) in the feed for the groups creation" do
    @group.save!
    user = Factory(:user)
    user.save!
    @group.add_creator(user)
    @group.feed.feed_items.first.text.should == "#{user.name} built the #{@group.name} Hub"
  end

  it "should put an entry in the feed for when a user leaves the group" do
    @group.save!
    user = Factory(:user)
    user.save!
    @group.add_user(user)
    @group.remove_user(user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => user.id, :feed_type => :user_left_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an entry in the feed for when a user joins the group" do
    @group.save!
    user = Factory(:user, :name => "new_user")
    user.save!
    @group.add_user(user)
    feed_item_count = @group.feed.feed_items.where( :referenced_model_id => @group.id,
                                                    :user_id => user.id, :feed_type => :user_joined_hub
                                                  ).count
    feed_item_count.should == 1
  end

  it "should invalidate images too large" do
    @group.should validate_attachment_size(:avatar).
                less_than(5.megabytes)
  end

  it "should invalidate images that are the wrong format" do
    @group.should validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
  end

  it "should have a default avatar image" do
    group = Factory( :group )
    group.avatar.url.should == 'no-image-original.png'
  end
end

