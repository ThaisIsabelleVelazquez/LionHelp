Feature: Browse services by category
  As a user
  I want to filter services by category
  So that I can quickly see only the type of service I am interested in

  Background: login and services in database
    Given the following accounts exist:
      | user_id | name      | email              | password   |
      | 1       | John Doe  | jd1234@columbia.edu | Password1! |

    And I am on the login page
    And I login with "jd1234@columbia.edu" and "Password1!"

    Given the following services exist:
      | title          | description             | category   | price | vendor_name |
      | Math Tutoring  | Help with math          | Tutoring   | 50    | John Doe    |
      | Grocery Pickup | Pickup groceries        | Food       | 20    | Jane Smith  |
      | Dorm Cleaning  | Clean dorm rooms        | Cleaning   | 30    | Mike Lee    |

  Scenario: Filter by Tutoring category
    When I go to the services page
    And I select a service category "Tutoring"
    Then I should see "Math Tutoring"
    And I should not see "Grocery Pickup"
    And I should not see "Dorm Cleaning"

  Scenario: Filter by Food category
    When I go to the services page
    And I select a service category "Food"
    Then I should see "Grocery Pickup"
    And I should not see "Math Tutoring"
    And I should not see "Dorm Cleaning"

  Scenario: Filter by Cleaning category
    When I go to the services page
    And I select a service category "Cleaning"
    Then I should see "Dorm Cleaning"
    And I should not see "Math Tutoring"
    And I should not see "Grocery Pickup"

  Scenario: Filter by All categories
    When I go to the services page
    And I select a service category "All"
    Then I should see "Math Tutoring"
    And I should see "Grocery Pickup"
    And I should see "Dorm Cleaning"
