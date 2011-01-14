Factory.define :user,:default_strategy => :build do |user|
  user.email                 "valid_user_email@valid.com"
  user.password              "valid_password"
  user.password_confirmation "valid_password"
  user.name                  "user"
  user.association            :gemslot
  user.after_build {|u|
    Factory(:feed, :source => u)}
end


Factory.define :gemslot do |gemslot|
  gemslot.association         :achievement
end

Factory.define :feed do |feed|
  feed.source            nil
end

Factory.define :group, :default_strategy => :build do |group|
  group.name                 "some_group"
  group.after_build {|g|
    Factory(:feed, :source => g)}
end

Factory.define :achievement, :default_strategy => :build do |achievement|
  achievement.name            "some_achievement"
end

Factory.sequence :email do |n|
  "valid_user_email#{n}@valid.com"
end

Factory.sequence :user_name do |n|
  "user#{n}"
end

Factory.sequence :group_name do |n|
  "some_group#{n}"
end

Factory.sequence :achievement_name do |n|
  "achievement#{n}"
end

