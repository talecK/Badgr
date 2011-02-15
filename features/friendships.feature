
Feature: Friendships Feature
    As a user I should be able to add friends, remove them, and see
    them in a list.

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password" and name "Friendly User"
	And a valid account "valid_friend@valid.com" exists with password "valid_password" and name "Some Friend"

    Scenario: Attempting to add yourself as a friend
	When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_user@valid.com"'s profile
	Then I should not see "Request Friendship"

    Scenario: Add a new friend
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is not a pending friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	And I follow "Request Friendship"
	Then I should see "Friendship request sent."
	And I should see "Friendship Pending"

    Scenario: View friendship pending status
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	Then I should see "Friendship Pending"
	And I should not see "(Accept) (Deny)"

    Scenario: View friendship pending status (inverse)
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
        When I log in as "valid_friend@valid.com" with password "valid_password"
        And I visit "valid_user@valid.com"'s profile
	Then I should see "Friendship Pending"

    Scenario: Being alerted of friend requests - profile page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	Then I should see "You have pending friendship requests!"
	
    Scenario: Being alerted of friend requests - friends page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I follow "My Friends"
	Then I should see "You have 1 pending friendship requests!"
	And I should see "Friendly User (Accept) (Deny)"

    Scenario: Viewing friend off of link - pending friend
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I follow "My Friends"
	And I follow "Friendly User"
	Then I should see "Friendly User's Profile"

    Scenario: Viewing friend off of link - confirmed friend
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I follow "My Friends"
	And I follow "Friendly User"
	Then I should see "Friendly User's Profile"


    Scenario: Accepting a friend request - friends page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I follow "My Friends"
	And I follow "Accept"
	Then I should see "Friend added."

    Scenario: Denying a friend request - friends page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I follow "My Friends"
	And I follow "Deny"
	Then I should see "Removed friend."

    Scenario: Accepting a friend request - friend's profile page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I visit "valid_user@valid.com"'s profile
	And I follow "Accept"
	Then I should see "Friend added."

    Scenario: Adding friends - feed items - user page
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        Then I should see "You and Some Friend are now friends"

    Scenario: Adding friends - feed items - friend's page
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	Then I should see "Some Friend and Friendly User are now friends"

    Scenario: Denying a friend request - friend's profile page
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
	When I log in as "valid_friend@valid.com" with password "valid_password"
	And I visit "valid_user@valid.com"'s profile
	And I follow "Deny"
	Then I should see "Removed friend."

    Scenario: Seeing all friends
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
	When I log in as "valid_user@valid.com" with password "valid_password"
	And I follow "My Friends"
	Then I should see "Some Friend"

    Scenario: Removing a friend - friends page
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
	When I log in as "valid_user@valid.com" with password "valid_password"
	And I follow "My Friends"
	And I follow "Remove"
	Then I should see "Removed friend."

    Scenario: Not adding a friend again/removing a friend - friend's profile page
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	And I follow "Remove Friend"
	Then I should see "Removed friend."

    Scenario: Viewing other people's friends
	And "valid_user@valid.com" is a friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	And I follow "View Friends"
	Then I should see "Friendly User"

    Scenario: Not viewing other people's pending friendships
	And "valid_user@valid.com" is a pending friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I visit "valid_friend@valid.com"'s profile
	And I follow "View Friends"
	Then I should not see "Friendly User"

    Scenario: Proper text for no friends - my page
	When I log in as "valid_user@valid.com" with password "valid_password"
	And I follow "My Friends"
	Then I should see "You have not added any friends yet!"

    Scenario: Proper text for no friends - other user's page
	When I log in as "valid_user@valid.com" with password "valid_password"
	And I visit "valid_friend@valid.com"'s profile
	And I follow "View Friends"
	Then I should see "Some Friend has not added any friends yet!"