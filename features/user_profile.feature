Feature: User Profile Feature
    As a logged in user I should be able to edit and view my
    profile

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And I log in as "valid_user@valid.com" with password "valid_password"

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

