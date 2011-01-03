Given /^"([^"]*)" belongs to "([^"]*)"$/ do | user_email, group |
	user = User.find_by_email( user_email )
  group = Factory(:group, :name => group)
  group.save!
  group.add_user( user )
end

Given /^the group "([^"]*)" exists$/ do |group|
  group = Factory(:group, :name => group)
  group.save!
end

When /^I view the "([^"]*)" page$/ do |group_name|
  visit group_path(Group.find_by_name(group_name))
end

