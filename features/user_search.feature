
Feature: User Search Feature
    As a user I should be able to search for other users to explore them and add them as friends.

    Background:
        Given I am not already logged in
        And I go to the home page
        And a valid account "valid_user@valid.com" exists with password "valid_password" and name "Friendly User"
	And a valid account "valid_friend@valid.com" exists with password "valid_password" and name "Some Friend"

    Scenario: Blank Search and friendship links
	When I log in as "valid_user@valid.com" with password "valid_password"
        And I press "submit_search"
	Then I should see "Friendly User"
	And I should not see "Friendly User (Request Friendship)"
	And I should see "Some Friend (Request Friendship)"

    Scenario: Search - add friend
	And "valid_user@valid.com" is not a friend of "valid_friend@valid.com"
	And "valid_user@valid.com" is not a pending friend of "valid_friend@valid.com"
        When I log in as "valid_user@valid.com" with password "valid_password"
        And I press "submit_search"
	And I follow "Request Friendship"
	Then I should see "Friendship request sent."
	And I should see "Friendship Pending"

    Scenario: Search for user
	When I log in as "valid_user@valid.com" with password "valid_password"
	And I fill in "search" with "riend"
        And I press "submit_search"
	Then I should see "Friendly User"
	And I should not see "Friendly User (Request Friendship)"
	And I should see "Some Friend (Request Friendship)"