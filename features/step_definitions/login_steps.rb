Given /^I am not already logged in$/ do
	visit '/users/sign_out'
end

Given /^I logout$/ do
	visit '/users/sign_out'
end

# "and name ____" is optional
Given /^a valid account "([^"]*)" exists with password "([^"]*)"(?: and name "([^"]*)")?$/ do | email, password, name |
		name = "user1" if (name.blank?)  #assign default name if its not given
		user = Factory(:user, :name => name, :email => email, :password => password, :password_confirmation => password)
		user.save!
end

Given /^I log in as "([^"]*)" with password "([^"]*)"$/ do | user_email, password |
		visit '/'
		fill_in( "user_email", :with => user_email )
		fill_in( "user_password", :with => password )
   	click_button( "user_submit" )
end

