Feature: Manage Services
    As a user
    I want to create, view, and delete services
    So that I can post and manage service requests

Background:
  Given the following services exist:
    | title        | description              | price | vendor_name | category  |
    | Laundry Help | Need help folding laundry | 15.00 | Emily  |  Tutoring  |
  Given the following accounts exist:
    | user_id    | name          | email             | password   |
    | 1          | John Doe      | jd1234@columbia.edu    | password   |
  And I am on the login page
  And I login with "jd1234@columbia.edu" and "password"

Scenario: Create a new service
    Given I am on the new service page
    When I fill in "Title" with "Laundry Help"
    And I fill in "Vendor Name" with "Emily"
    And I fill in "Description" with "Need help folding laundry"
    And I fill in "Price" with "15.00"
    And I press "Create Service Post"
    Then I should see "Laundry Help"
    And I should see "Service created successfully!"


  Scenario: View a service
    When I go to the service details page for "Laundry Help"
    Then I should see "Laundry Help"
    And I should see "Need help folding laundry"

  Scenario: Delete a service
    When I delete the service "Laundry Help"
    Then I should see "Service 'Laundry Help' deleted."