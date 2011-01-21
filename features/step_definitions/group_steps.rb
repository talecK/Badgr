Given /^"([^"]*)" belongs to "([^"]*)"$/ do | user_email, group_name |
	user = User.find_by_email( user_email )
  group = Group.find_by_name(group_name)
  group.add_user( user )
end

Given /^the group "([^"]*)" exists$/ do |group|
  group = Factory(:group, :name => group)
  group.save!
end

When /^I view the "([^"]*)" page$/ do |group_name|
  visit group_path(Group.find_by_name(group_name))
end

Given /^"([^"]*)" built the "([^"]*)" Hub$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.add_creator(user)
end

Given /^"([^"]*)" is a group admin for "([^"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.make_admin!(user)
end

