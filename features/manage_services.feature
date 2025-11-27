Feature: Manage Services
    As a user
    I want to create, view, and delete services
    So that I can post and manage service requests

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
    Given the following service exists:
      | title        | description              | price | vendor_name | category  |
      | Laundry Help | Need help folding laundry | 15.00 | Emily  |  Tutoring  |
    When I go to the service details page for "Laundry Help"
    Then I should see "Laundry Help"
    And I should see "Need help folding laundry"

  Scenario: Delete a service
    Given the following service exists:
      | title        | description              | price | vendor_name |  category  |
      | Laundry Help | Need help folding laundry | 15.00 | Emily  |  Tutoring  |
    When I delete the service "Laundry Help"
    Then I should see "Service 'Laundry Help' deleted."