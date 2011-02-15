require 'spec_helper'

describe UserAchievement do
  before(:each) do
    @user = Factory(:user)
    @achievement = Factory(:achievement)
  end

  it "should require a status" do
    user_achievement = @user.user_achievements.build(:achievement_id => @achievement.id)
    user_achievement.should_not be_valid
  end

  it "should be able to be presented by another user" do
    group_officer = Factory(:user, :email => Factory.next(:email))
    group = Factory(:group)
    group.add_user(group_officer)
    group.add_user(@user)
    group.make_admin!(group_officer)
    user_achievement = @user.user_achievements.create(:achievement_id => @achievement.id, :status => :pending)
    user_achievement.present_by( group_officer )
    user_achievement.status.should == :awarded
    user_achievement.presenter.should == group_officer
    @user.user_achievements.count.should == 1
  end
end

