Feature: User Profile Feature
    As a logged in user I should be able to edit and view my
    profile

    Background:
        Given I am not already logged in
        And I go to the home page
        And my account "valid_user@valid.com" exists with password "valid_password" and is valid
        And I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: Avatar Image
        When I follow "Edit profile"
        And I attach the file "spec/fixtures/valid_avatar.png" to "user_avatar"
        And I press "Update User"
        Then I should see "Profile has been updated"

    Scenario: Invalid Avatar Image
        When I follow "Edit profile"
        And I attach the file "spec/fixtures/invalid_avatar.psd" to "user_avatar"
        And I press "Update User"
        Then I should see "Can only upload jpeg, jpg, png and gif file types"

    Scenario: Gem Slot
        Given "valid_user@valid.com" has achieved the "Gem" achievement
        When I follow "Click to set gem"
        Then I should see "Select an acheivement to put in your gem slot"
        When I choose "Gem"
        And I press "Update"
        Then I should see "Your gem has been updated"
        And I should see "Gem" within the gemslot

