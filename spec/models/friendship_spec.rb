require 'spec_helper'

describe Friendship do

	before(:each) do
		@user = Factory(:user)
		@friend = Factory(:user, :email => "valid_friend@valid.com", :name => "Some Friend")

		@friendship = @user.friendships.build(:friend_id => @friend.id, :pending => true)
	end

	it "should create a new instance given valid attributes" do
		@friendship.save!
	end
	
	describe "friend methods" do

    before(:each) do
      @friendship.save
    end

    it "should have a user attribute" do
      @friendship.should respond_to(:user)
    end

    it "should have the right user" do
      @friendship.user.should == @user
    end

    it "should have a friend attribute" do
      @friendship.should respond_to(:friend)
    end

    it "should have the right friend" do
      @friendship.friend.should == @friend
    end
	
	it "should include the friend in the friends array" do
		@user.friends.should include(@friend)
	end
	
	it "should remove friends from the friend array" do
		@friendship.destroy
		@user.friends.should_not include(@friend)
	end
	
	it "should include the user in the inverse_friendships array" do
		@friend.inverse_friends.should include(@user)
	end
	
	it "should remove users from the inverse_friendships array" do
		@friendship.destroy
		@friend.inverse_friends.should_not include(@user)
	end
  end
  
  describe "validations" do

    it "should require a user_id" do
      @friendship.user_id = nil
      @friendship.should_not be_valid
    end

    it "should require a friend_id" do
      @friendship.friend_id = nil
      @friendship.should_not be_valid
    end
	
	it "should require a pending status" do
      @friendship.pending = nil
      @friendship.should_not be_valid
    end
  end

end
