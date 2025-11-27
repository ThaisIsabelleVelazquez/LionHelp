Feature: View all services
  As a Columbia student
  So that I can browse services offered by others
  I want to see a list of all services on the homepage

  Background:
    Given the following services exist:
      | title                 | description                         | price | vendor_name     |  category  |
      | Meal Swipes           | Swipe access to dining halls         | 9.00  | Kathy Lee  |  Meal Swipes  |
      | Tutoring – COMS W1004 | Personalized help with intro CS      | 25.00 | John Doe   |  Tutoring  |
    Given the following accounts exist:
      | user_id    | name          | email             | password   |
      | 1          | John Doe      | jd1234@columbia.edu    | password   |
    And I am on the login page
    And I login with "jd1234@columbia.edu" and "password"

  Scenario: Viewing the list of services
    When I go to the services page
    Then I should see "Meal Swipes"
    And I should see "Tutoring – COMS W1004"