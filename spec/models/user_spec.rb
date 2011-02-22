require 'spec_helper'

describe User do
  before (:each) do
    @user = Factory( :user )
    @friend = Factory(:user, :email => "valid_friend@valid.com", :name => "Some Friend")
	@øfriend.save!
  end

  it "should require an email addres" do
    no_email_user = Factory(:user, :email => "" )
    no_email_user.should_not be_valid
  end

	it "should require a password" do
		no_passw_user = Factory(:user, :password => "" )
		no_passw_user.should_not be_valid
	end

	#it "should require a name" do
		#no_name_user = User.new( @attr.merge( :name => "" ) )
		#no_name_user.should_not be_valid
	#end

	#it "should reject user names that are too long" do
	#	long_name = 'c' * 31
	#	long_name_user = User.new( @attr.merge( :name => long_name) )
	#	long_name_user.should_not be_valid
	#end

	it "should only accept valid emails" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Factory( :user, :email => address )
      valid_email_user.should be_valid
    end
	end

	it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Factory( :user, :email => address )
      invalid_email_user.should_not be_valid
    end
	end

	it "should reject email addresses identical up to case" do
	  @user.save!
		upcased_email = Factory.attributes_for(:user)[:email].upcase
		user_with_duplicate_email = Factory(:user, :email => upcased_email )
		user_with_duplicate_email.save.should == false
	end

  it "should require a name" do
    user = Factory(:user, :name => "")
    user.should_not be_valid
  end


  # Can't get the next two tests working properly yet... works in dev but fails here

  #it "can set its avatar to a valid image" do
    #user = Factory( :user, :avatar => File.join( Rails.root, "spec/fixtures/valid_avatar.png" ).open )
    #puts user.avatar.url
    #user.avatar.url.should_not == 'no-image.png'
  #end

  #it "should not attach invalid files" do
    #@user.avatar = Rails.root.join( "spec/fixtures/invalid_avatar.psd" ).open
    #puts @user.avatar.url
    #@user.avatar.url.should == 'no-image.png'
  #end

  it "should invalidate images too large" do
    @user.should validate_attachment_size(:avatar).
                less_than(5.megabytes)
  end

  it "should invalidate images that are the wrong format" do
    @user.should validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
  end

  it "should have a default avatar image" do
    user = Factory( :user )
    user.avatar.url.should == 'no-image-original.png'
  end

  it "should be able to be made a super admin" do
    @user.save!
    @user.make_super_admin!
    @user.role.should == User::ROLES[0]
  end

  it "should be able to revoke super admin status" do
    @user.save!
    @user.revoke_super_admin!
    @user.role.should == nil
  end

  it "should have a friendships method" do
    @user.should respond_to(:friendships)
  end

  it "should have a friends method" do
    @user.should respond_to(:friends)
  end

  it "should have an inverse_friendships method" do
    @user.should respond_to(:inverse_friendships)
  end
  
  it "should use has_friend? to determine an existing friendship" do
		@friendship = @user.friendships.build(:friend_id => @friend.id, :pending => true)
		@friendship.save!
		@user.has_friend?(@friend).should == @friendship
	end
	
	it "should use has_friend? to determine an existing friendship" do
		@user.has_friend?(@friend).should == nil
	end

  it "should be able to request achievements" do
    @user.save!
    achievement = Factory(:achievement)
    @user.request_achievement(achievement)
    @user.user_achievements.find_by_achievement_id(achievement.id).status.should == UserAchievement::STATES[:pending]
  end

  it "should be able to tell if the user has a certain achievement pending" do
    @user.save!
    group = Factory(:group)
    group.save!
    achievement = group.achievements.build( :name => "achievement",
                                             :description => "some_description",
                                             :requirements => "some_requirements")
    achievement.creator = @user
    achievement.save!

    achievement2 = group.achievements.build( :name => "achievement2",
                                              :description => "some_description",
                                              :requirements => "some_requirements")
    achievement2.creator = @user
    achievement2.save!

    @user.request_achievement(achievement)
    @user.has_pending_achievement?(achievement).should == true
    @user.has_pending_achievement?(achievement2).should == false
  end
end

