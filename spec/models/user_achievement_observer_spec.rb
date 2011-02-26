require 'spec_helper'

describe UserAchievementObserver do
  before (:each) do
    @user = Factory(:user)
    @admin = Factory(:user, :email => Factory.next(:email))
    @group = Factory(:group)
    @group.save!
    @user.save!
    @admin.save!

    @group.add_user(@user)
    @group.add_user(@admin)
    @group.make_admin!(@admin)
    @achievement = @group.achievements.build( :name => "achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements")
    @achievement.creator = @admin
    @achievement.save!
    @user_achievement = @user.request_achievement(@achievement)
  end

  it "should place a feed item in the feed for the user and their corresponding group when the user earns an achievement" do
    @user_achievement.present_by( @admin )
    @group.feed.feed_items.exists?(:feed_type => :user_earned_achievement).should == true
    @user.feed.feed_items.exists?(:feed_type => :user_earned_achievement).should == true
  end
end

