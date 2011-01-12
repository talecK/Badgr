Feature: Feed Item Feature
    As a user I should see logs of important events involving myself, my groups, and my fellow group members

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: Viewing a properly formed feed item in the group feed (for joining a group)
        Given I follow "Some Group"
        Then I should see "user1 is now a member of the Some Group Hub" within "#hub_feed"
        And I should see "user1" within "#hub_feed"
        And I should see the time the feed item was created for "valid_user@valid.com" joining the "Some Group" Hub

    @wip
    Scenario: viewing a properly formed feed item in the user feed (for joining a group) in "first person"
        Then I should see "You became a member of the Some Group Hub"


    @javascript
    Scenario: Deleting a feed feed (all ajax-y and the like...)
        Given I follow "Some Group"
        When I click remove for the feed item with reference "valid_user@valid.com", source "Some Group" and type "user_joined_hub"
        Then I should not see "user1 is now a member of the Some Group Hub" within "#hub_feed"

    Scenario: Clicking on the source of a feed item
        When I follow "Some Group"
        And I follow "user1" within "#hub_feed .feed_item"
        Then I should see "user1's Profile"

