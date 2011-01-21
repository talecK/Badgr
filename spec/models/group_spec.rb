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

  it "should be able to make a member a group admin" do
    user = Factory(:user)
    user.save!
    @group.save!
    @group.add_user(user)
    @group.make_admin!(user)
    @group.has_admin?(user).should == true
  end

  it "should be able to tell if a user is an admin" do
    user = Factory(:user)
    user.save!
    @group.save!
    @group.add_user(user)
    @group.has_admin?(user).should == false
  end

  it "should be able to tell if a user is not an admin if the user doesn't belong to the group" do
    user = Factory(:user)
    user.save!
    @group.save!
    @group.has_admin?(user).should == false
  end
end

