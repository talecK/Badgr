When /^I visit the create a new achievement page for "([^"]*)"$/ do |group_name|
  group = Group.find_by_name(group_name)
  visit new_group_achievement_path(group)
end

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

Given /^"([^"]*)" has forged the "([^"]*)" for "([^"]*)"$/ do |user_email, achievement_name, group_name|
    user = User.find_by_email(user_email)
    group = Group.find_by_name(group_name)
    achievement = group.achievements.build( :name => achievement_name,
                                            :description => "some_description",
                                            :requirements => "some_requirements"
                                          )

    achievement.image = File.open( "./spec/fixtures/valid-gem.png" )
    achievement.creator = user
    achievement.save!
end

