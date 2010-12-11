Given /^I am not already logged in$/ do
	visit '/users/sign_out'
end

Given /^my account "([^"]*)" exists with password "([^"]*)" and is valid$/ do | email, password |
    attributes = { :password_confirmation => password, :password => password, :email => email }
		user = User.create!( attributes )
		user.save!
end

Given /^I am logged in as "([^"]*)"$/ do | user_email |
    attributes = { :password_confirmation => "valid_password", :password => "valid_password", :email => user_email }
		user = User.create!( attributes )
		user.save!
		visit '/'
		fill_in( "user_email", :with => user_email )
		fill_in( "user_password", :with => "valid_password" )
   		click_button( "user_submit" )
end
