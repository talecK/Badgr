Given /^"([^"]*)" has achieved the "([^"]*)" achievement$/ do |user_name, achievement_name|
  user = User.find_by_email( user_name )
  achievement = user.achievements.build( :name => achievement_name )
  achievement.image = File.open( "./spec/fixtures/valid-gem.png" )
  achievement.save!
end

