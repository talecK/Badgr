Given /^I am not already logged in$/ do
	visit '/users/sign_out'
end

Given /^my account "([^"]*)" exists with password "([^"]*)" and is valid$/ do | email, password |
    attributes = { :name => "test_name",:password_confirmation => password, :password => password, :email => email }
		user = User.create!( attributes )
		user.save!
end

Given /^I log in as "([^"]*)" with password "([^"]*)"$/ do | user_email, password |
		visit '/'
		fill_in( "user_email", :with => user_email )
		fill_in( "user_password", :with => password )
   	click_button( "user_submit" )
end

