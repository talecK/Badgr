require 'spec_helper'
require "cancan/matchers"

describe Ability do
  before (:each) do
    @group = Factory(:group)
    @group.save!

    @creator = Factory(:user)
    @creator.save!
    @group.add_creator(@creator)

    @admin = Factory(:user, :email => Factory.next(:email))
    @admin.save!
    @group.add_user(@admin)
    @group.make_admin!(@admin)

    @user = Factory(:user, :email => Factory.next(:email))
    @user.save!
    @group.add_user(@user)
  end

  it "should not let non-admin users from a group delete other users from the group" do
    other_user = Factory(:user, :email => Factory.next(:email))
    @group.add_user(other_user)

    ability = Ability.new(@user)
    ability.should_not be_able_to(:destroy, @group.get_membership(@admin))
    ability.should_not be_able_to(:destroy, @group.get_membership(@creator))
    ability.should_not be_able_to(:destroy, @group.get_membership(other_user))
  end

  it "should let admins ban normal users but not creators or other admins" do
    other_admin = Factory(:user, :email => Factory.next(:email))
    @group.add_user(other_admin)
    @group.make_admin!(other_admin)

    ability = Ability.new(@admin)
    ability.should be_able_to(:destroy, @group.get_membership(@user))
    ability.should_not be_able_to(:destroy, @group.get_membership(@creator))
    ability.should_not be_able_to(:destroy, @group.get_membership(other_admin))
  end

  it "should let creators ban normal users and admins" do
    ability = Ability.new(@creator)
    ability.should be_able_to(:destroy, @group.get_membership(@user))
    ability.should be_able_to(:destroy, @group.get_membership(@admin))
  end

  it "should not let you ban yourself" do
    ability = Ability.new(@admin)
    ability.should_not be_able_to(:destroy, @group.get_membership(@admin))

    ability = Ability.new(@creator)
    ability.should_not be_able_to(:destroy, @group.get_membership(@creator))

    ability = Ability.new(@user)
    ability.should_not be_able_to(:destroy, @group.get_membership(@user))
  end

  it "should let group creators promote other members to admins" do
    ability = Ability.new(@creator)
    ability.should be_able_to(:promote, @group.get_membership(@user))
  end

  it "should not let group creators promote members that are already admins" do
    ability = Ability.new(@creator)
    ability.should_not be_able_to(:promote, @group.get_membership(@admin))
  end

  it "should not let normal users or group admins promote any type of user" do
    other_admin = Factory(:user, :email => Factory.next(:email))
    @group.add_user(other_admin)
    @group.make_admin!(other_admin)

    other_user = Factory(:user, :email => Factory.next(:email))
    @group.add_user(other_user)

    ability = Ability.new(@admin)
    ability.should_not be_able_to(:promote, @group.get_membership(@user))
    ability.should_not be_able_to(:promote, @group.get_membership(@creator))
    ability.should_not be_able_to(:promote, @group.get_membership(other_admin))

    ability = Ability.new(@user)
    ability.should_not be_able_to(:promote, @group.get_membership(other_user))
    ability.should_not be_able_to(:promote, @group.get_membership(@creator))
    ability.should_not be_able_to(:promote, @group.get_membership(@admin))
  end
end

