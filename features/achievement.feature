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
        And I should see a feed item with text "You forged the test_achievement Achievement" once within the feed
        When I follow "My Profile"
        Then I should see a feed item with text "You forged the test_achievement Achievement" once within the feed

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

    Scenario: Requesting an acheivement
        Given "valid_user@valid.com" belongs to "Some Group"
        And a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "hub_admin@valid.com" has forged the "test_achievement" for "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "View achievements"
        And I follow "Request" within "#test_achievement-achievement"
        And I press "Request"
        Then I should see "A request for the test_achievement has been sent to the officers of the Some Group Hub."
        And the page should not have css "input[value='Request']" within "#test_achievement-achievement"
        And I should see "Pending" within "#test_achievement-achievement"

    Scenario: Trying to request an achievement you've already requested by url
        Given "valid_user@valid.com" belongs to "Some Group"
        And a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "hub_admin@valid.com" has forged the "test_achievement" for "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        When I follow "View achievements"
        And I follow "Request" within "#test_achievement-achievement"
        And I press "Request"
        Then I should see "A request for the test_achievement has been sent to the officers of the Some Group Hub."
        Then I should see "Pending" within "#test_achievement-achievement"
        When I try and request "test_achievement" for "Some Group" by url as "valid_user@valid.com"
        Then I should see "Either that resource does not exist or you do not have permission to access it."

    @javascript
    Scenario: Confirming a requested achievement as an admin of Some Group
        Given "valid_user@valid.com" belongs to "Some Group"
        And a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "hub_admin@valid.com" has forged the "test_achievement" for "Some Group"
        And I log in as "valid_user@valid.com" with password "valid_password"
        And "valid_user@valid.com" has requested the "test_achievement" for "Some Group"
        And I logout
        And I log in as "hub_admin@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "Manage achievement requests"
        Then I should see "Pending" within "#valid_user-valid-com-test_achievement"
        When I follow "View request" within "#valid_user-valid-com-test_achievement"
        And I press "Award" and click OK
        Then I should see "You have awarded valid_user@valid.com the 'test_achievement' achievement."
        When I logout
        And I log in as "valid_user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "View achievements"
        Then I should see "Awarded" within "#test_achievement-achievement"

    Scenario: Users should not be able to confirm their own achievements
        Given a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "hub_admin@valid.com" has forged the "test_achievement" for "Some Group"
        When I log in as "hub_admin@valid.com" with password "valid_password"
        And "hub_admin@valid.com" has requested the "test_achievement" for "Some Group"
        And I view the "Some Group" page
        And I follow "Manage achievement requests"
        And I follow "View request" within "#hub_admin-valid-com-test_achievement"
        Then the page should not have css "input[value='Award']"

    Scenario: Only admins or creators should be able to confirm achievements
        Given "valid_user@valid.com" belongs to "Some Group"
        And I log in as "valid_user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        Then I should not see "Manage acheivement requests"

    @javascript
    Scenario: Denying a user an achievement as an admin
        Given "valid_user@valid.com" belongs to "Some Group"
        And a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "hub_admin@valid.com" has forged the "test_achievement" for "Some Group"
        And I log in as "valid_user@valid.com" with password "valid_password"
        And "valid_user@valid.com" has requested the "test_achievement" for "Some Group"
        And I logout
        And I log in as "hub_admin@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "Manage achievement requests"
        Then I should see "Pending" within "#valid_user-valid-com-test_achievement"
        When I follow "View request" within "#valid_user-valid-com-test_achievement"
        And I press "Deny" and click OK
        Then I should see "You have denied valid_user@valid.com the 'test_achievement' achievement."
        When I logout
        And I log in as "valid_user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "View achievements"
        Then I should see "Denied" within "#test_achievement-achievement"

