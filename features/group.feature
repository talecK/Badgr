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
        When I view the "Some Group" page
        Then I should see "Leave group"
        When I follow "Leave group" and click OK
        Then I should see "You have left the Some Group hub"

    Scenario: Seeing all members of a Group
        And I follow "Some Group"
        When I follow "View members"
        Then I should see "Some Group Hub - Memberlist"
        And I should see "valid_user@valid.com"

    Scenario: Joining the Hub
        Given the group "Another Group" exists
        When I view the "Another Group" page
        And I follow "Join Hub"
        Then I should see "You are now a member of the Another Group Hub."

    Scenario: Trying to join a Hub you already belong to
        When I follow "Some Group"
        Then I should not see "Join Hub"

    @javascript
    Scenario: Updating the group avatar as an administrator
        Given "valid_user@valid.com" is a group admin for "Some Group"
        When I view the "Some Group" page
        And I follow "Edit group"
        And I attach the file "spec/fixtures/valid_avatar.png" to "Avatar image"
        And I press "Update Group"
        Then show me the page
        Then I should see "Some Group Hub has been updated"

    Scenario: Only group administrators and super admins should be able to edit a group
        When I follow "Some Group"
        Then I should not see "Edit group"
        When I visit the edit group page for "Some Group"
        Then I should see "Either that resource does not exist or you do not have permission to access it."

        Given I am not already logged in
        And I go to the home page
        And a valid account "super_admin@valid.com" exists with password "valid_password"
        And "super_admin@valid.com" is a super admin
        And I log in as "super_admin@valid.com" with password "valid_password"
        When I view the "Some Group" page
        Then I should see "Edit"
        When I visit the edit group page for "Some Group"
        Then I should not see "Either that resource does not exist or you do not have permission to access it."

    @javascript
    Scenario: Invalid Group avatar Image
        Given "valid_user@valid.com" is a group admin for "Some Group"
        When I view the "Some Group" page
        And I follow "Edit group"
        And I attach the file "spec/fixtures/invalid_avatar.png" to "Avatar image"
        And I press "Update Group"
        Then I should see "Can only upload jpeg, jpg, png and gif file types"

    Scenario: Viewing Administrators for the group
        Given "valid_user@valid.com" is a group admin for "Some Group"
        When I view the "Some Group" page
        And I follow "View Hub Admins"
        Then I should see "valid_user@valid.com"

    @javascript
    Scenario: Banning a member from a hub as a group admin
        Given "valid_user@valid.com" is a group admin for "Some Group"
        And a valid account "banned@valid.com" exists with password "valid_password" and name "banned_user"
        And "banned@valid.com" belongs to "Some Group"
        When I view the "Some Group" page
        And I follow "View members"
        And I press "Ban" and click OK within "#banned-valid-com"
        Then I should see "banned@valid.com has been banned from the Some Group Hub."
        And I should not see "banned@valid.com" within "#memberlist"
        When I view the "Some Group" page
        Then I should see a feed item with text "banned_user was banned from the Some Group Hub" once within the feed
        When I visit the profile for "valid_user@valid.com"
        Then I should see a feed item with text "banned_user was banned from the Some Group Hub" once within the feed

    Scenario: Only Hub admins can ban members
        And a valid account "banned@valid.com" exists with password "valid_password" and name "banned_user"
        And "banned@valid.com" belongs to "Some Group"
        When I view the "Some Group" page
        And I follow "View members"
        Then the page should not have css "input[value='Ban']" within "#banned-valid-com"

    @javascript
    Scenario: Only group creators should be able to ban admins
        Given "valid_user@valid.com" is the creator for the "Some Group" Hub
        And a valid account "banned@valid.com" exists with password "valid_password" and name "banned_user"
        And "banned@valid.com" belongs to "Some Group"
        And "banned@valid.com" is a group admin for "Some Group"
        When I view the "Some Group" page
        And I follow "View members"
        And I press "Ban" and click OK within "#banned-valid-com"
        Then I should see "banned@valid.com has been banned from the Some Group Hub."
        And I should not see "banned@valid.com" within "#memberlist"
        When I view the "Some Group" page
        Then I should see a feed item with text "banned_user was banned from the Some Group Hub" once within the feed
        When I visit the profile for "valid_user@valid.com"
        Then I should see a feed item with text "banned_user was banned from the Some Group Hub" once within the feed

    @javascript
    Scenario: Only group creators should be able to promote other members to admins
        Given "valid_user@valid.com" is the creator for the "Some Group" Hub
        And a valid account "promoted@valid.com" exists with password "valid_password" and name "promoted_user"
        And "promoted@valid.com" belongs to "Some Group"
        When I view the "Some Group" page
        And I follow "View members"
        When I press "Promote" and click OK within "#promoted-valid-com"
        Then I should see "promoted@valid.com has been promoted to group_admin"
        Then the page should not have css "input[value='Promote']" within "#promoted-valid-com"
        And "promoted@valid.com" should be a group admin for "Some Group"

    Scenario: Normal users and hub admins shouldn't be able to promote anyone
        Given "valid_user@valid.com" is a group admin for "Some Group"
        And a valid account "user@valid.com" exists with password "valid_password" and name "some_user"
        And "user@valid.com" belongs to "Some Group"
        And a valid account "creator@valid.com" exists with password "valid_password" and name "creator_user"
        And "creator@valid.com" belongs to "Some Group"
        And "creator@valid.com" is the creator for the "Some Group" Hub

        When I view the "Some Group" page
        And I follow "View members"
        Then the page should not have css "input[value='Promote']"
        Given I am not already logged in
        And I go to the home page
        When I log in as "user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "View members"
        Then the page should not have css "input[value='Promote']"

    @javascript
    Scenario: Only group creators should be able to demote other admins to normal users
        Given "valid_user@valid.com" is the creator for the "Some Group" Hub
        And a valid account "demoted@valid.com" exists with password "valid_password" and name "promoted_user"
        And "demoted@valid.com" belongs to "Some Group"
        And "demoted@valid.com" is a group admin for "Some Group"
        When I view the "Some Group" page
        And I follow "View members"
        When I press "Demote" and click OK within "#demoted-valid-com"
        Then show me the page
        Then I should see "demoted@valid.com has been demoted to member"
        Then the page should not have css "input[value='Demote']" within "#demoted-valid-com"
        And "demoted@valid.com" should be a regular member for "Some Group"

    Scenario: Normal users and hub admins shouldn't be able to demote anyone
        Given "valid_user@valid.com" is a group admin for "Some Group"
        And a valid account "user@valid.com" exists with password "valid_password" and name "some_user"
        And "user@valid.com" belongs to "Some Group"
        And a valid account "creator@valid.com" exists with password "valid_password" and name "creator_user"
        And "creator@valid.com" belongs to "Some Group"
        And "creator@valid.com" is the creator for the "Some Group" Hub

        When I view the "Some Group" page
        And I follow "View members"
        Then the page should not have css "input[value='Demote']"
        Given I am not already logged in
        And I go to the home page
        When I log in as "user@valid.com" with password "valid_password"
        And I view the "Some Group" page
        And I follow "View members"
        Then the page should not have css "input[value='Demote']"

