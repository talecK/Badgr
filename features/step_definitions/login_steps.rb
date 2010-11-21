Given /^I am not already logged in$/ do
end

When /^I visit the site$/ do
	visit '/'
end

Then /^the login page should say "([^"]*)"$/ do |arg1|
  response.should contain("Please Login")
end

Given /^that I am not already logged in$/ do
  pending # express the regexp above with the code you wish you had
end

When /^when I enter "([^"]*)" into the "([^"]*)" field$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^"([^"]*)" into the "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be redirected to my "([^"]*)" page$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the site should say "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end