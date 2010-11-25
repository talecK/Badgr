Feature: Login Descriptions
    As a user of visiting the Achievements website
    I should be greeted to a login page
    And be able to log in

    Scenario: Visiting the main site
        Given I am not already logged in
		When I visit the site
        Then the login page should say "Please Login"

    Scenario: Logging in with a valid user name and valid password
        Given that I am not already logged in
        When when I enter "valid_user_name" into the "user_name" field
        And "valid_password" into the "password_field"
        Then I should be redirected to my "profile" page

    Scenario: Logging in with an invalid user name and valid password
        Given that I am not already logged in
        When when I enter "invalid_user_name" into the "user_name" field
        And "valid_password" into the "password_field"
        Then the site should say "Invalid Username or Password"

    Scenario: Logging in with an valid user name and invalid password
        Given that I am not already logged in
        When when I enter "valid_user_name" into the "user_name" field
        And "invalid_password" into the "password_field"
        Then the site should say "Invalid Username or Password"


   

