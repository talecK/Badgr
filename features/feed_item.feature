Feature: Feed Item Feature
    As a user I should see logs of important events involving myself, my groups, and my fellow group members

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: Viewing a properly formed feed item
        Given I follow "Some Group"
        Then I should see "user1 is now a member of the Some Group Hub" within "#hub_feed #feed_item"
        And I should see "user1" within "#hub_feed #feed_item"
        And I should see the time "user1" created the feed_item within "#hub_feed #feed_item"

