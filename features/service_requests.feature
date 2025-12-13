Feature: Service Requests
  As a user
  I want to send, accept, and decline service requests
  So that I can manage my services

  Background:
    Given the following accounts exist:
      | user_id | name       | email               | password    |
      | 1       | John Doe   | jd1234@columbia.edu | Password1! |
      | 2       | Kathy Lee  | kl4567@columbia.edu  | Password2! |

    Given the following services exist for service requests:
  | title        | description       | price | category  | vendor_name |
  | Test Service | Help with testing | 50    | Testing   | John Doe    |


  Scenario: Sending a service request
    Given I am logged in as "Kathy Lee"
    When I send a request for "Test Service" to "John Doe" with message "Please help me"
    Then I should see "Request sent!"


  Scenario: Viewing inbox
    Given I am logged in as "John Doe"
    And there is a pending request from "Kathy Lee" for "Test Service"
    When I visit my inbox
    Then I should see "Kathy Lee" under "Incoming Pending"
    And I should see "Test Service" under "Incoming Pending"

  Scenario: Accepting a request
    Given I am logged in as "John Doe"
    And there is a pending request from "Kathy Lee" for "Test Service"
    When I accept the request from "Kathy Lee"
    Then I should see "Request updated"
    And the request status should be "accepted"

  Scenario: Declining a request
    Given I am logged in as "John Doe"
    And there is a pending request from "Kathy Lee" for "Test Service"
    When I decline the request from "Kathy Lee"
    Then I should see "Request updated"
    And the request status should be "declined"
