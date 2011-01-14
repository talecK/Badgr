require 'spec_helper'

describe Membership do
  before( :each ) do
    @group = Factory(:group)
    @user = Factory(:user)
    @attr = { :user_id => @user.id, :group_id => @group.id, :group_admin => false }
  end

  it "should default creator to false" do
    group_user = @user.memberships.create!( @attr )
    group_user.group_creator.should == false
  end

  it "should create an instance given valid attributes" do
    group_user = @user.memberships.build( @attr )
    group_user.save!
  end

  it "should require an admin flag" do
    group_user = @user.memberships.build( @attr.merge( :group_admin => nil ) )
    group_user.should_not be_valid
  end

  it "should respond to is_group_admin?" do
    group_user = @user.memberships.build( @attr )
    group_user.should respond_to( :is_group_admin? )
  end

  it "should be able to be made group admin" do
    group_user = @user.memberships.build( @attr )
    group_user.make_group_admin!
    group_user.is_group_admin?.should == true
  end

  it "should be able to have its group admin status revoked" do
    group_user = @user.memberships.build( @attr.merge( :group_admin => true )  )
    group_user.revoke_group_admin!
    group_user.is_group_admin?.should == false
  end
end

