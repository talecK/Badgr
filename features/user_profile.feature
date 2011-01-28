Feature: User Profile Feature
    As a logged in user I should be able to edit and view my
    profile

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: I should be able to edit my profile
        Then I should see "Edit Profile"

    Scenario: No one else besides me and site admins should be able to edit my profile
        Given I am not already logged in
        And I go to the home page
        And a valid account "other_user@valid.com" exists with password "valid_password"
        When I log in as "other_user@valid.com" with password "valid_password"
        And I visit the profile for "valid_user@valid.com"
        Then I should not see "Edit Profile"
        When I visit the edit profile page for "valid_user@valid.com"
        Then I should see "Either that resource does not exist or you do not have permission to access it."

        Given I am not already logged in
        And I go to the home page
        And a valid account "super_admin@valid.com" exists with password "valid_password"
        And "super_admin@valid.com" is a super admin
        And I log in as "super_admin@valid.com" with password "valid_password"
        And I visit the profile for "valid_user@valid.com"
        Then I should see "Edit Profile"
        When I visit the edit profile page for "valid_user@valid.com"
        Then I should not see "Either that resource does not exist or you do not have permission to access it."

    @javascript
    Scenario: Avatar Image
        When I follow "Edit Profile"
        And I attach the file "spec/fixtures/valid_avatar.png" to "user_avatar"
        And I press "Update User"
        Then I should see "Profile has been updated"

    @javascript
    Scenario: Invalid Avatar Image
        When I follow "Edit Profile"
        And I attach the file "spec/fixtures/invalid_avatar.psd" to "user_avatar"
        And I press "Update User"
        Then I should see "Can only upload jpeg, jpg, png and gif file types"

    Scenario: Gem Slot
        Given the group "Some Group" exists
        And "valid_user@valid.com" belongs to "Some Group"
        And "valid_user@valid.com" has achieved the "Gem" achievement from "Some Group"
        When I follow "Click to set gem"
        Then I should see "Select an acheivement to put in your gem slot"
        When I choose "Gem"
        And I press "Update"
        Then I should see "Your gem has been updated"
        And I should see "Gem" in the gemslot

