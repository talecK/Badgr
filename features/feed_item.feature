Feature: Feed Item Feature
    As a user I should see logs of important events involving myself, my groups, and my fellow group members

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password"
        And the group "Some Group" exists
        And "valid_user@valid.com" belongs to "Some Group"
        When I log in as "valid_user@valid.com" with password "valid_password"

    Scenario: Viewing a properly formed feed item in the group feed (for joining a group)
        Given I follow "Some Group"
        Then I should see "You became a member of the Some Group Hub" within "#hub_feed"
        And I should see "user1" within "#hub_feed"
        And I should see the time the feed item was created for "valid_user@valid.com" joining the "Some Group" Hub

    Scenario: viewing a properly formed feed item in the user feed (for joining a group) in "first person"
        Then I should see "You became a member of the Some Group Hub"

    @javascript
    Scenario: Deleting a feed feed (all ajax-y and the like...)
        When I view the "Some Group" page
        When I click remove for the feed item with reference "valid_user@valid.com", source "Some Group" and type "user_joined_hub"
        Then I should not see "You became a member of the Some Group Hub" within "#hub_feed"

    Scenario: Clicking on the source of a feed item
        When I follow "Some Group"
        And I follow "user1" within "#hub_feed .feed_item"
        Then I should see "user1's Profile"

    Scenario: The group feed, building and joining a group by two different users, one of which is logged in
              and should have first person text

        Given a valid account "creator@valid.com" exists with password "valid_password" and name "user2"
        And "creator@valid.com" built the "Some Group" Hub
        When I follow "Some Group"
        Then I should see "user2 built the Some Group Hub" within "#hub_feed"
        And I should see "You became a member of the Some Group Hub"

    Scenario: When a user joins or leaves a group all members in the group should have it posted in their feed
              and in the case of the user who joined or left this should occour only once in their feed in first person

        Given I am not already logged in
        And a valid account "creator@valid.com" exists with password "valid_password" and name "user2"
        And a valid account "user1@valid.com" exists with password "valid_password" and name "user1"
        And "creator@valid.com" built the "Some Group" Hub
        And "user1@valid.com" belongs to "Some Group"
        And I log in as "user1@valid.com" with password "valid_password"
        Then I should see a feed item with text "You became a member of the Some Group Hub" once within the feed

    Scenario: When a user earns an achievement, it should place a feed item in the group feed as well as the user's feed
        Given "valid_user@valid.com" has achieved the "test" achievement from "Some Group"
        And I view the "Some Group" page
        Then show me the page
        Then I should see a feed item with text "You earned the test Achievement" once within the feed
        When I follow "My Profile"
        Then I should see a feed item with text "You earned the test Achievement" once within the feed

    Scenario: When a user is denied an achievement, it should place a private feed item in their feed which other users can't see
        Given a valid account "hub_admin@valid.com" exists with password "valid_password"
        And "hub_admin@valid.com" belongs to "Some Group"
        And "hub_admin@valid.com" is a group admin for "Some Group"
        And "valid_user@valid.com" was denied the "test" achievement from "Some Group" by "hub_admin@valid.com"
        When I follow "My Profile"
        Then I should see a feed item with text "Your request for the test Achievement was denied" once within the feed
        Given I logout
        And I log in as "hub_admin@valid.com" with password "valid_password"
        When I visit the profile for "valid_user@valid.com"
        Then I should not see a feed item with text "Your request for the test Achievement was denied" within the feed

