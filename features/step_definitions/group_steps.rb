Given /^"([^"]*)" belongs to "([^"]*)"$/ do | user_email, group |
	user = User.find_by_email( user_email )
  group = Factory(:group, :name => group )
  group.save!
  group.add_user( user )
end

