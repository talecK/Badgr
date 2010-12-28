require 'spec_helper'

describe Gemslot do
  before (:each) do
    @user = Factory(:user)
  end

  it "should be able to showcase another achievement" do
    @user.gemslot.achievement = Factory(:achievement, :name => "test")
    @user.gemslot.achievement.name.should == "test"
  end

  it "should build an achievement automatically" do
    @user.gemslot.achievement.nil?.should == false
  end
end

