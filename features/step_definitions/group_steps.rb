Given /^"([^"]*)" belongs to "([^"]*)"$/ do | user_email, group |
	user = User.where( :email => user_email )
  group = Group.create!( :name => group )
	group.save!
	group_user = group.group_users.build( :group_admin => false )
	group_user.save!
end

