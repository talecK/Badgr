Feature: Group Feature
    As a user I should be able to create and interact with group

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And the group "Some Group" exists
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
        And I should see "user1"

    Scenario: Joining the Hub
        Given the group "Another Group" exists
        When I view the "Another Group" page
        And I follow "Join Hub"
        Then I should see "You are now a member of the Another Group Hub."

    Scenario: Trying to join a Hub you already belong to
        When I follow "Some Group"
        Then I should not see "Join Hub"

    @javascript
    Scenario: Updating the group avatar
        When I follow "Some Group"
        And I follow "Edit group"
        And I attach the file "spec/fixtures/valid_avatar.png" to "Avatar image"
        And I press "Update Group"
        Then I should see "Some Group Hub has been updated"

    @javascript
    Scenario: Invalid Group avatar Image
        When I follow "Some Group"
        And I follow "Edit group"
        And I attach the file "spec/fixtures/invalid_avatar.png" to "Avatar image"
        And I press "Update Group"
        Then I should see "Can only upload jpeg, jpg, png and gif file types"

