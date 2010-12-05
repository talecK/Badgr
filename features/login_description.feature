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
        And my account "valid_user_email@email.com" exists with password "valid_password" and is valid
        When I fill in "user[email]" with "valid_user_email@email.com"
        And I fill in "user[password]" with "valid_password"
        And I press "user_submit"
        Then I should see "My Profile"

    Scenario: Logging in with an invalid user name and invalid password
        Given I am not already logged in
        When I fill in "user[email]" with "valid_user_email@email.com"
        And I fill in "user[password]" with "valid_password"
        And I press "user_submit"
        Then I should see "Invalid email or password."

    Scenario: Logging in with an valid user name and invalid password
        Given I am not already logged in
        And my account "valid_user_email@email.com" exists with password "valid_password" and is valid
        When I fill in "user[email]" with "valid_user_email@email.com"
        And I fill in "user[password]" with "invalid_valid_password"
        And I press "user_submit"
        Then I should see "Invalid email or password."


   

