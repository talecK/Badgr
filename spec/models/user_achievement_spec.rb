require 'spec_helper'

describe UserAchievement do
  before(:each) do
    @user = Factory(:user)
    @creator = Factory(:user, :email => Factory.next(:email) )
    @creator.save!
    @group = Factory(:group)
    @group.save!
    @achievement = @group.achievements.build( :name => "achievement",
                                          :description => "some_description",
                                          :requirements => "some_requirements")
    @achievement.creator = @creator
    @achievement.save!
    @group_officer = Factory(:user, :email => Factory.next(:email))
    @group_officer.save!
    @group.add_user(@group_officer)
    @group.add_user(@user)
    @group.make_admin!(@group_officer)
    @user_achievement = @user.user_achievements.create(:achievement_id => @achievement.id, :status => UserAchievement::STATES[:Pending])
  end

  it "should require a status" do
    user_achievement = @user.user_achievements.build(:achievement_id => @achievement.id)
    user_achievement.should_not be_valid
  end

  it "should be able to be presented by another user" do
    @user_achievement.present_by( @group_officer )
    @user_achievement.status.should == UserAchievement::STATES[:Awarded]
    @user_achievement.presenter.should == @group_officer
    @user.user_achievements.count.should == 1
  end

  it "should be able to be denied by another user" do
    @user_achievement.deny_by( @group_officer )
    @user_achievement.status.should == UserAchievement::STATES[:Denied]
    @user_achievement.presenter.should == @group_officer
    @user.user_achievements.count.should == 1
  end
end

