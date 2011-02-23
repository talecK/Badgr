When /^I visit the create a new achievement page for "([^"]*)"$/ do |group_name|
  group = Group.find_by_name(group_name)
  visit new_group_achievement_path(group)
end

# This is kinda an all in one method that makes the achievement then awards it, might need to be reworked as this may cause
# programmers to think this method simply "awards" the achievement
Given /^"([^"]*)" has achieved the "([^"]*)" achievement from "([^"]*)"$/ do |user_name, achievement_name, group_name|
  user = User.find_by_email( user_name )
  group = Group.find_by_name( group_name )
  achievement = group.achievements.build( :name => achievement_name, :description => "test", :requirements => "test" )
  achievement.creator = user
  achievement.image = File.open( "./spec/fixtures/valid-gem.png" )
  achievement.save!

  # achievement.request_achievement()
  # achievement.present_by( Factory( :user, :email => Factory.next( :email ) ) )
  user.user_achievements.create(:achievement_id => achievement.id, :status => UserAchievement::STATES[:awarded])
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

When /^I try and request "([^"]*)" for "([^"]*)" by url as "([^"]*)"$/ do |achievement_name, group_name, user_name|
  user = User.find_by_email( user_name )
  group = Group.find_by_name( group_name )
  achievement = group.achievements.find_by_name(achievement_name)
  visit new_user_user_achievement_path(user, :achievement_id => achievement.id)
end

Given /^"([^"]*)" has requested the "([^"]*)" for "([^"]*)"$/ do |user_email, achievement_name, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  achievement = group.achievements.find_by_name(achievement_name)
  within_str = '"#' + "#{achievement.name}-achievement\""
  When %{I view the "#{group.name}" page}
  And %{I follow "View achievements"}
  And %{I follow "Request" within #{within_str}}
  And %{I press "Request"}
end

