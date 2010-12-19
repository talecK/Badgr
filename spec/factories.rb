Factory.define :user,:default_strategy => :build do |user|
  user.email                 "valid_user_email@valid.com"
  user.password              "valid_password"
  user.password_confirmation "valid_password"
end

Factory.define :group, :default_strategy => :build do |group|
  group.name                 "some_group"
end

Factory.sequence :email do |n|
  "valid_user_email#{n}@valid.com"
end

Factory.sequence :group_name do |n|
  "some_group#{n}"
end

