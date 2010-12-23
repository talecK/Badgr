require 'spec_helper'

describe Achievement do
  before ( :each ) do
    @user = Factory( :user )
    @achievement = Factory( :achievement )
  end

  it "should require a name" do
    no_name_achievement = Factory( :achievement, :name => ""  )
    no_name_achievement.should_not be_valid
  end

  it "should belong to a user" do
    achievement = @user.achievements.build
    achievement.name = "test"
    achievement.save!
  end
end

