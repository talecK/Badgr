Given /^I am not already logged in$/ do
	visit '/users/sign_out'
end

Given /^my account "([^"]*)" exists with password "([^"]*)" and is valid$/ do | email, password |
    @attributes = { :password_confirmation => password, :password => password, :email => email }
		@user = User.create!( @attributes )
		@user.save!
end

Given /^there are the following users:$/ do |table|
	table.hashes.each do |attributes|
		unconfirmed = attributes.delete( "unconfirmed" )
		@user = User.create!( attributes.merge!( :password_confirmation => attributes[:password] ) )
		@user.confirm! unless unconfirmed
	end
end