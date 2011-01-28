Then /^I should see "([^"]*)" in the gemslot$/ do |gem|
  page.should have_xpath('//a[@title="'+gem+'"]')
end

Given /^I visit the profile for "([^"]*)"$/ do |email|
  visit user_path( User.find_by_email(email) )
end

Given /^"([^"]*)" is a super admin$/ do |email|
  User.find_by_email(email).make_super_admin!
end

When /^I visit the edit profile page for "([^"]*)"$/ do |user_email|
  visit edit_user_path(User.find_by_email(user_email))
end

