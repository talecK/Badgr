Feature: Registration Feature
    As a new user to the site I should be 
    able to register
    
    Scenario: Seeing a registration link on the main page
        Given I am not already logged in
        And I am on the homepage
        Then I should see "sign up"
        
    Scenario: Getting to registration page
        Given I am not already logged in
        And I am on the homepage
        When I follow "Sign up"
        Then I should see "Email"
        And I should see "Password"
        And I should see "Password confirmation"
        And I should see "Sign up"