require 'spec_helper'

describe AchievementObserver do
  before (:each) do
    @group = Factory(:group)
    @group.save!
    @user = Factory(:user)
    @user.save!
  end

  it "should put an (exactly one) item in the creators feed when a new achievement is forged" do
    @achievement = @group.achievements.build( :name => "some_achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements"
                                            )

    @achievement.creator = @user
    @achievement.save!
    feed_item_count = @user.feed.feed_items.where( :referenced_model_id => @achievement.id,
                                                    :user_id => @user.id, :feed_type => :user_forged_achievement
                                                  ).count
    feed_item_count.should == 1
  end

  it "should put an (exactly one) item in the group feed when a new achievement is forged" do
    @achievement = @group.achievements.build( :name => "some_achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements"
                                            )

    @achievement.creator = @user
    @achievement.save!
    feed_item_count = @user.feed.feed_items.where( :referenced_model_id => @achievement.id,
                                                    :user_id => @user.id, :feed_type => :user_forged_achievement
                                                  ).count
    feed_item_count.should == 1
  end
end

