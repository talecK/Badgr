require 'spec_helper'

describe Achievement do
  before ( :each ) do
    @user = Factory( :user )
    @group = Factory(:group)
    @user.save
    @group.save
    @achievement = Factory( :achievement )
  end

  it "should require a name" do
    no_name_achievement = Factory( :achievement, :name => ""  )
    no_name_achievement.should_not be_valid
  end

  it "should require a description" do
    no_description_achievement = Factory( :achievement, :description => ""  )
    no_description_achievement.should_not be_valid
  end

  it "should require requirements" do
    no_description_achievement = Factory( :achievement, :requirements => ""  )
    no_description_achievement.should_not be_valid
  end

  it "should invalidate images too large" do
    @achievement.should validate_attachment_size( :image ).
                less_than(5.megabytes)
  end

  it "should invalidate images that are the wrong format" do
    @achievement.should validate_attachment_content_type( :image ).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
  end

  it "should have a default gem image" do
    @achievement.image.url.should == 'no-gem-image.png'
  end

  it "should be able to have its image set" do
    @achievement.image = File.open("./spec/fixtures/valid-gem.png")
    @achievement.image.url.include?("valid-gem.png").should == true
  end

  it "should require a unique name within the group it belongs to" do
    achievement = @group.achievements.build( :name => "achievement",
                                             :description => "some_description",
                                             :requirements => "some_requirements")
    achievement.creator = @user
    achievement.save!

    achievement2 = @group.achievements.build( :name => "achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements")
    achievement2.creator = @user
    achievement2.should_not be_valid
  end

  it "should allow duplicate achievement names across 2 seperate groups" do
    group2 = Factory(:group, :name => Factory.next(:group_name))

    achievement = @group.achievements.build( :name => "achievement",
                                             :description => "some_description",
                                             :requirements => "some_requirements")
    achievement.creator = @user
    achievement.save!

    achievement2 = group2.achievements.build( :name => "achievement",
                                              :description => "some_description",
                                              :requirements => "some_requirements")
                                               achievement.creator = @user
    achievement2.creator = @user
    achievement2.should be_valid
  end

end

