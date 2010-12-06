Feature: Dashboard Feature
    As a logged in user I should always have access to my 
    Dashboard so I can perform common tasks on any page
    
    Scenario: Logout Link
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user_email@email.com" exists with password "valid_password" and is valid
        When I fill in "user[email]" with "valid_user_email@email.com"
        And I fill in "user[password]" with "valid_password"
        And I press "user_submit"
        Then I should see "Logout"