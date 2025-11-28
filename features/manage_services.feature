Feature: Manage Services
    As a user
    I want to create, view, and delete services
    So that I can post and manage service requests

Background:
  Given the following services exist:
    | title        | description              | price | vendor_name | category  |
    | Headshot | I can take your professional headshots for LinkedIn! | 15.00 | Emily Burnett  |  Career  |
    | Tutoring | I can help you study for COMSW4001 | 15.00 | Emily Burnett  |  Tutoring  |
    | Manicures | Able to do acyrlics and gel. | 65.00 | Linda Wells  |  Salon  |
  Given the following accounts exist:
    | user_id    | name          | email             | password   |
    | 1          | Emily Burnett     | eb1234@columbia.edu    | password   |

  Given the following reviews exist:
    | client_id | vendor_id | vendor_name          | title      | rating | comment                                                  | reviewer | client_name |
    | 10          | 1          | Emily Burnett         | Tutoring  | 4      | Explained things clearly                            | client  | John Doe |
    | 11          | 3          | Hannah Lasso         | Furniture  | 3      | My chair had a scratch on the back.                     | client  | Kathy Lee |
  And I am on the login page
  And I login with "eb1234@columbia.edu" and "password"

Scenario: Create a new service
    Given I am on the new service page
    When I fill in "Title" with "Laundry Help"
    And I fill in "Vendor Name" with "Emily"
    And I fill in "Description" with "Need help folding laundry?"
    And I fill in "Price" with "15.00"
    And I press "Create Service Post"
    Then I should see "Laundry Help"
    And I should see "Service created successfully!"


  Scenario: View a service
    When I go to the service details page for "Tutoring"
    Then I should see "Tutoring"
    And I should see "I can help you study for COMSW4001"
    And I should see "Explained things clearly"
    And I should not see "My chair had a scratch on the back."
  
  Scenario: See all the services I own
    When I am on my services page
    Then I should see "Tutoring"
    Then I should see "Headshot"
    Then I should not see "Manicures"
  
  Scenario: I update a service of mine
    When I am on my services page
    And I click Edit for the service "Headshot"
    And I fill in "Price" with "20"
    And I fill in "Title" with "LinkedIn Shots"
    And I press "Update"
    Then I should see "LinkedIn Shots"
    Then I should see "20"

  Scenario: I update a service of mine with bad values
    When I am on my services page
    And I click Edit for the service "Headshot"
    And I fill in "Price" with "-20"
    And I press "Update"
    Then I should see "Price is negative"

  Scenario: I delete a service of mine
    When I am on my services page
    And I click Edit for the service "Headshot"
    And I press Delete
    Then I should not see "Headshot deleted."
  
