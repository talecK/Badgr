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
        When I follow "gem_slot"
        Then I should see "Please select an achievement to display"
        And I press "NewGem"
        Then I should see "Gem Slot has been updated"

