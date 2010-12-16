Given /^"([^"]*)" belongs to "([^"]*)"$/ do | user_email, group |
	user = User.find_by_email( user_email )
  group = Group.create!( :name => group )
  group.add_user( user )
end

