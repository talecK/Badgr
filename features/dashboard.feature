Feature: Dashboard Feature
    As a logged in user I should always have access to my 
    Dashboard so I can perform common tasks on any page
    
    Scenario: Dashboard Links
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user_email@email.com" exists with password "valid_password" and is valid
        When I fill in "user[email]" with "valid_user_email@email.com"
        And I fill in "user[password]" with "valid_password"
        And I press "user_submit"
        Then I should see "Logout"
        And I should see "My Profile"
        And I should see "My User Page"
        And I should see "My friends"
        And I should see "My Groups"
        And I should see "My Trophy Case"
        
    Scenario: Viewing My Groups
        Given I am logged in as "valid_user@valid.com"
        And "valid_user@valid.com" belongs to "Some Group"
        When I click "My Groups" 
        Then I should see "Some Group"