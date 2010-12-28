Feature: Group Feature
    As a user I should be able to create and interact with group

    Background:
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user@valid.com" exists with password "valid_password" and is valid

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
        Then I should see "Some Group's Hub"

    Scenario: Leaving a Group
        Given "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        Then I should see "Leave group"
        When I press "Leave group"
        Then I should see "Are you sure you want to leave this group?"
        When I press "ok"
        Then I should see "You are no longer a member of Some Group"

