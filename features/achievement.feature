Feature: Achievements
    As a logged in user I should be able to view my own achievements as well as the
    available achievements for any group(s) I belong to

    @wip
    Scenario: Creating an achievement
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And the group "Some Group" exists
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I follow "Some Group"
        And I follow "Create achievement"
        And I fill in "Achievement" for "Name"
        And I fill in "Just some achievement..." for "Description"
        And I attach the file "valid-gem.png" to "File"
        And I fill "earn it" for "Requirement"

