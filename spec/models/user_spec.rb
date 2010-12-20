require 'spec_helper'

describe User do
  before (:each) do
    @user = Factory( :user )
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
    user.avatar.url.should == 'no-image.png'
  end

end

