When /^I visit the create a new achievement page for "([^"]*)"$/ do |group_name|
  group = Group.find_by_name(group_name)
  visit new_group_achievement_path(group)
end

