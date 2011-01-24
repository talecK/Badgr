Feature: Achievements
    As a logged in user I should be able to view my own achievements as well as the
    available achievements for any group(s) I belong to

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password" and name "user1"
        And the group "Some Group" exists

    Scenario: Creating an achievement as a group admin
        And "valid_user@valid.com" belongs to "Some Group"
        Given "valid_user@valid.com" is a group admin for "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        And I follow "Create achievement"
        And I fill in "test_achievement" for "Achievement name"
        And I fill in "Just some achievement..." for "Achievement description"
        And I attach the file "spec/fixtures/valid-gem.png" to "Achievement image"
        And I fill in "earn it" for "Achievement requirement"
        And I press "Create Achievement"
        Then I should see "Achievement was successfully created."
        And I should see a feed item with text "You forged the 'test_achievement' Achievement" once within the feed
        When I follow "My Profile"
        Then I should see a feed item with text "You forged the 'test_achievement' Achievement" once within the feed

    Scenario: Viewing all achievements in a group
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        Given "valid_user@valid.com" has achieved the "test_achievement" achievement from "Some Group"
        And I follow "View achievements"
        Then I should see "test_achievement"

    Scenario: Normal user trying to forge an achievement for a group they belong to
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        Then I should not see "Create achievement"

    Scenario: Group creator trying to forge an achievement for a group they created
        Given "valid_user@valid.com" built the "Some Group" Hub
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        And I follow "Create achievement"
        Then I should not see "Either that resource does not exist or you do not have permission to access it."

    Scenario: User who is not an admin for a group trying to create an achievement by visiting the create url
        Given "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit the create a new achievement page for "Some Group"
        Then I should see "Either that resource does not exist or you do not have permission to access it."

