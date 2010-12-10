Given /^"([^"]*)"$ belongs to "([^"]*)"$/ do | user_email, group |
	user = User.find( user_email )
  group = Group.create!( :name => "" )
	group.save!
	group_user = group.group_users.build( :group_admin => false )
	group_user.save!
end