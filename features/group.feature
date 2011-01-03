Feature: Group Feature
    As a user I should be able to create and interact with group

    Background:
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user@valid.com" exists with password "valid_password" and is valid
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: Creating a Group
        When I follow "Create a Group"
        Then I should see "Group name"
        When I fill in "group[name]" with "NewGroup"
        And I press "Create Group"
        Then I should see "My Profile"
        And I should see "NewGroup"

    Scenario: Visiting a Group
        When I follow "Some Group"
        Then I should see "Some Group Hub"

    @javascript
    Scenario: Leaving a Group
        When I follow "Some Group"
        Then I should see "Leave group"
        When I follow "Leave group" and click OK
        Then I should see "You have left the Some Group hub"

    Scenario: Seeing all members of a Group
        And I follow "Some Group"
        When I follow "View members"
        Then I should see "Some Group Hub - Memberlist"
        And I should see "test_name"
        Then show me the page

    Scenario: Joining the Hub
        Given the group "Another Group" exists
        When I view the "Another Group" page
        And I follow "Join Hub"
        Then show me the page
        Then I should see "You are now a member of the Another Group Hub."

    @wip
    Scenario: Trying to join a Hub you already belong to
        When I follow "Some Group"
        Then I should not see "Join Hub"

    @wip
    Scenario: The group feed
        When I follow "Some Group"
        Then I should see ""

