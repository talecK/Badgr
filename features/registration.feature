Feature: Registration Feature
    As a new user to the site I should be 
    able to register
    
    Scenario: Seeing a registration link on the main page
        Given I am not already logged in
        And I am on the homepage
        Then I should see "sign up"