Feature: Achievements
    As a logged in user I should be able to view my own achievements as well as the
    available achievements for any group(s) I belong to

    @wip
    Scenario: Creating an achievement
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password" and name "user1"
        And the group "Some Group" exists
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        And I follow "Create achievement"
        And I fill in "test_achievement" for "Achievement name"
        And I fill in "Just some achievement..." for "Achievement description"
        And I attach the file "spec/fixtures/valid-gem.png" to "Achievement image"
        And I fill in "earn it" for "Achievement requirement"
        And I press "Create Achievement"
        And show me the page
        Then I should see "Achievement was successfully created."
        And I should see "You forged the test_achievement Achievement" within "#hub_feed"
        When I follow "My Profile"
        Then I should see a feed item with text "You forged the test_achievement Achievement" once within the feed

