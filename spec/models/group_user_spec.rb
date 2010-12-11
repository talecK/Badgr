require 'spec_helper'

describe GroupUser do
  before( :each ) do
    @group = Factory(:group)
    @user = Factory(:user)
    @group_user = @user.group_users.build( :user_id => @user.id, :group_id => @group.id, :group_admin => false )
  end

  it "should create an instance given valid astributes" do
    @group_user.save!
  end

  it "should require an admin flag" do
    @group_user.should_not be_valid
  end

  it "should respond to is_group_admin?" do
    @group_user.should respond_to( :is_group_admin? )
  end

  it "should be able to be made group admin" do
    @group_user.make_group_admin!
    @group_user.is_group_admin? should_be(true)
  end

  it "should be able to have its group admin status revoked" do
    @group_user.revoke_group_admin!
    @group_user.is_group_admin? should_be(true)
  end
end

