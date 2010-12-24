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

end

