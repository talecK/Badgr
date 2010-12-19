Feature: Dashboard Feature
    As a logged in user I will always have access to my
    Dashboard so I can perform common tasks on any page

    Background:
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user@valid.com" exists with password "valid_password" and is valid

    Scenario: Dashboard Links
        When I log in as "valid_user@valid.com" with password "valid_password"
        Then I should see "Logout"
        And I should see "My Profile"
        And I should see "My User Page"
        And I should see "My friends"
        And I should see "My Groups"
        And I should see "My Trophy Case"

    Scenario: Viewing My Groups
        Given "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        Then I should see "Some Group"

    Scenario: Creating a Group
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Create a Group"
        Then I should see "Group name"
        When I fill in "group[name]" with "NewGroup"
        And I press "Create Group"
        Then I should see "My Profile"
        And I should see "NewGroup"

    Scenario: Visiting a Group
        Given "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        Then I should see "Some Group Profile"

