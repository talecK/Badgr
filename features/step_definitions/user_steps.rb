Given /^"([^"]*)" has achieved the "([^"]*)" achievement from "([^"]*)"$/ do |user_name, achievement_name,group_name|
  user = User.find_by_email( user_name )
  group = Group.find_by_name( group_name )
  achievement = group.achievements.build( :name => achievement_name, :description => "test", :requirements => "test" )
  achievement.creator = user
  achievement.image = File.open( "./spec/fixtures/valid-gem.png" )
  achievement.save!

  user.achievements << achievement
  user.save!
end

Then /^I should see "([^"]*)" in the gemslot$/ do |gem|
  page.should have_xpath('//a[@title="'+gem+'"]')
end

