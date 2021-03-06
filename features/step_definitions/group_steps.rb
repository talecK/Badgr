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

When /^I visit the edit group page for "([^"]*)"$/ do |group_name|
  visit edit_group_path(Group.find_by_name(group_name))
end

Given /^"([^"]*)" is the creator for the "([^"]*)" Hub$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.make_creator!(user)
end

Then /^"([^"]*)" should be a group admin for "([^"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  member = group.get_membership(user)
  member.role.should == Membership::ROLES[1]
end

Then /^"([^"]*)" should be a regular member for "([^"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  member = group.get_membership(user)
  member.role.should == Membership::ROLES[0]
end

