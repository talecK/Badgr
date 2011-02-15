Given /^"([^"]*)" is not a friend of "([^"]*)"$/ do |user_email, friend_email|
	user = User.find_by_email (user_email)
	friend = User.find_by_email (friend_email)
	friendship = user.friendships.find_by_friend_id(friend)
	friendship.destroy if friendship.nil? == false
end

Given /^"([^"]*)" is not a pending friend of "([^"]*)"$/ do |user_email, friend_email|
	user = User.find_by_email (user_email)
	friend = User.find_by_email (friend_email)
	friendship = user.friendships.find_by_friend_id_and_pending(friend, false)
	friendship.destroy if friendship.nil? == false
end

When /^I visit "([^"]*)"'s profile$/ do |friend_email|
	visit user_path(User.find_by_email (friend_email))
end

Given /^"([^"]*)" is a pending friend of "([^"]*)"$/ do |user_email, friend_email|
	user = User.find_by_email(user_email)
	friend = User.find_by_email(friend_email)
	friendship = user.friendships.find_by_friend_id(friend)
	friendship.destroy if friendship.nil? == false
	friendship = user.friendships.build(:friend_id => friend.id, :pending => true)
	friendship.save!
end

Given /^"([^"]*)" is a friend of "([^"]*)"$/ do |user_email, friend_email|
	user = User.find_by_email(user_email)
	friend = User.find_by_email(friend_email)
	friendship = user.friendships.build(:friend_id => friend.id, :pending => false)
	friendship.save!
	feed_type = :user_added_friend
	feed_item = FeedItem.create( :feed_type => feed_type)
	feed_item.user = friendship.user
	feed_item.referenced_model = friendship.friend
    feed_item.save!
    friendship.user.feed.add_feed_item( feed_item )
	feed_item = FeedItem.create( :feed_type => feed_type)
	feed_item.user = friendship.friend
	feed_item.referenced_model = friendship.user
    feed_item.save!
    friendship.friend.feed.add_feed_item( feed_item )
end
