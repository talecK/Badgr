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
        And I attach the file "spec/fixtures/valid_avatar.jpg" to "avatar_input_box"
        Then I should see "valid_avatar.jpg"

    @wip
    Scenario: Invalid Avatar Image
        When I follow "Edit profile"
        And I attach the file "spec/fixtures/invalid_avatar.jpg" to "avatar_input_box"
        Then I should see "Unable to set avatar image"

