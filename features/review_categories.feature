Feature: Browse reviews by category
  As a user
  I want to filter reviews by category

  Background: login and reviews in database
    Given the following accounts exist:
    |  user_id  | name              | email              | password |
    |  1     | John Doe          | jd1234@columbia.edu     | Password1! |
    |  10    | Kathy Lee         | kl1234@barnard.edu    | Password1! |
    |  3     | Hannah Lasso      | hl1234@barnard.edu   | Password1! |
    |  4     | Barbara Reddington| br1234@barnard.edu  | Password1! |
    |  11    | Janine Abbott     | ja1234@columbia.edu   | Password1! |
  
    And I am on the login page
    And I login with "jd1234@columbia.edu" and "Password1!"

    Given the following reviews exist:
    | client_id | vendor_id | vendor_name          | title      | rating | comment                                                  | reviewer | client_name |
    | 1          | 3          | Hannah Lasso         | Furniture  | 4      | Personally delivered to me.                             | client  | John Doe |
    | 2          | 3          | Hannah Lasso         | Furniture  | 3      | My chair had a scratch on the back.                     | client  | Kathy Lee |
    | 5          | 3          | Hannah Lasso         | Furniture  | 5      | Was really friendly.                                    | client  | Janine Abbott |
    | 4          | 3          | Hannah Lasso         | Furniture  | 5      | Sold at a really good price                             | client  | Barbara Reddington |
    | 1          | 4          | Barbara Reddington   | Manicure   | 1      | The nail design was not like the picture I showed.      | client  | John Doe |
    | 4          | 1          | John Doe             | Haircut   | 2      | They were late to the appointment.                      | vendor  | Barbara Reddington |
    | 3          | 4          | Barbara Reddington   | Manicure   | 1      | They were so rude to me.                               | client  | Hannah Lasso |

  
  
  Scenario: Filter by Reviews About Me (As Client)
    Given I am on the review home page
    When I select a review category "Reviews About Me (As Client)"
    Then I should see "Reviews About Me As A Client"
    And I should not see "Reviews About Me As A Vendor"

Scenario: Filter by Reviews About Me (As Vendor)
    Given I am on the review home page
    When I select a review category "Reviews About Me (As Vendor)"
    Then I should see "Reviews About Me As A Vendor"
    And I should not see "Reviews About Me As A Client"


  Scenario: Reviews I wrote
    Given I am on the review home page
    When I select a review category "Reviews I Wrote"
    Then I should see "Reviews I Wrote"
    And I should not see "Reviews About Me As A Client"
    And I should not see "Reviews About Me As A Vendor"

  Scenario: Filter by All reviews
    Given I am on the review home page
    When I select a review category "All Reviews"
    Then I should see "All Reviews"


  Scenario: Successfully update a review
      Given I am on the review home page
      And I select a review category "Reviews I Wrote"
      Then I should see "Personally delivered to me."
      When I edit the review with comment "Personally delivered to me."
      And I fill in the review content with "Excellent session!"
      And I fill in the review rating with "5"
      And I submit the updated review
      Then I should see notice "Review was successfully updated."
      And I should see "Excellent session!"

  Scenario: User deletes their own review
    Given I am on the review home page
    And I select a review category "Reviews I Wrote"
    When I delete the review "Hannah Lasso", "Furniture", "Personally delivered to me.", "4"
    Then I should see notice "Review deleted"
    And I should not see "Personally delivered to me."