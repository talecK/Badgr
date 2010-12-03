Feature: Login Descriptions
    As a user of visiting the Achievements website
    I should be greeted to a login page
    And be able to log in

    Scenario: Visiting the main site
        Given I am not already logged in
		When I go to the home page
        Then I should be on the sign in page
        Then I should see "Sign in"

    Scenario: Logging in with a valid user name and valid password
        Given I am not already logged in
        And my account exists and is valid
        When I fill in "user[email]" with "valid_user_name"
        And I fill in "user[password]" with "valid_password"
        Then I should see "My Profile"

    Scenario: Logging in with an invalid user name and valid password
        Given I am not already logged in
        When when I enter "invalid_user_name" into the "user_name" field
        And "valid_password" into the "password_field"
        Then the site should say "Invalid Username or Password"

    Scenario: Logging in with an valid user name and invalid password
        Given I am not already logged in
        When when I enter "valid_user_name" into the "user_name" field
        And "invalid_password" into the "password_field"
        Then the site should say "Invalid Username or Password"


   

