Factory.define :user do |user|
  user.email                 "valid_user_email@valid.com"
  user.password              "valid_password"
  user.password_confirmation "valid_password"
end

Factory.define :group do |group|
  group.name                 "some_group"
end

