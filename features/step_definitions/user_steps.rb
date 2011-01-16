Given /^"([^"]*)" has achieved the "([^"]*)" achievement$/ do |user_name, achievement_name|
  user = User.find_by_email( user_name )
  achievement = Factory(:achievement, :name => achievement_name)
  achievement.image = File.open( "./spec/fixtures/valid-gem.png" )
  achievement.save!

  user.achievements << achievement
  user.save!
end

Then /^I should see "([^"]*)" in the gemslot$/ do |gem|
  page.should have_xpath('//a[@title="'+gem+'"]')
end

