require 'spec_helper'
require 'rack/test'
require "cancan/matchers"

describe UserAchievementsController do
  include Devise::TestHelpers

  before(:each) do
    @user = Factory( :user )
    @user.save!
    @group = Factory( :group )
    @group.save!
    @group.add_user(@user)
    @achievement = @group.achievements.build( :name => "achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements")

    @creator = Factory( :user, :email => Factory.next( :email ) )
    @creator.save!
    @achievement.creator = @creator
    @achievement.save!

    @user_achievement = @user.request_achievement(@achievement)
  end

  it "shouldn't let normal users confirm achievements" do
    user2 = Factory( :user, :email => Factory.next(:email) )
    @group.add_user(user2)
    sign_in user2

    put :update, :group_id => @group.id, :id => @user_achievement.id, :commit => "Award"
    response.should redirect_to( user_path( user2 ) )
  end

  it "should let admins confirm achievements" do
    admin = Factory( :user, :email => Factory.next(:email) )
    @group.add_user(admin)
    @group.make_admin!( admin )
    sign_in admin

    put :update, :group_id => @group.id, :id => @user_achievement.id, :commit => "Award"
    response.should redirect_to( group_user_achievements_path( @group ) )
    flash[:error].should == nil
  end

  it "should let group creators confirm achievement requests" do
    creator = Factory( :user, :email => Factory.next(:email) )
    @group.add_creator( creator )
    sign_in creator

    put :update, :group_id => @group.id, :id => @user_achievement.id, :commit => "Award"
    response.should redirect_to( group_user_achievements_path( @group ) )
    flash[:error].should == nil
  end

  it "shouldn't let admins confirm their own achievements" do
    creator = Factory( :user, :email => Factory.next(:email) )
    @group.add_creator( creator )
    sign_in creator
    creators_user_achievement = creator.request_achievement( @achievement )

    ability = Ability.new(creator)
    puts ability.can?(:award, creators_user_achievement )
    put :update, :group_id => @group.id, :id => creators_user_achievement.id, :commit => "Award"
    response.should redirect_to( user_path( creator ) )
    flash[:error].should_not == nil
  end

  it "shouldn't let group creators confirm their own achievement requests" do
    admin = Factory( :user, :email => Factory.next(:email) )
    @group.add_user(admin)
    @group.make_admin!( admin )
    sign_in admin
    admin_user_achievement = admin.request_achievement( @achievement )

    put :update, :group_id => @group.id, :id => admin_user_achievement.id, :commit => "Award"
    response.should redirect_to( user_path( admin ) )
    flash[:error].should_not == nil
  end
end

