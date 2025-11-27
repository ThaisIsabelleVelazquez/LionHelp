Feature: View all services
  As a Columbia student
  So that I can browse services offered by others
  I want to see a list of all services on the homepage

  Background:
    Given the following services exist:
      | title                 | description                         | price | vendor_name     |  category  |
      | Meal Swipes           | Swipe access to dining halls         | 9.00  | Kathy Lee  |  Meal Swipes  |
      | Tutoring – COMS W1004 | Personalized help with intro CS      | 25.00 | John Doe   |  Tutoring  |

  Scenario: Viewing the list of services
    When I go to the services page
    Then I should see "Meal Swipes"
    And I should see "Tutoring – COMS W1004"