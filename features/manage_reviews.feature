Feature: Manage Reviews
    As a user,
    I want to create, view, and delete reviews
    So that I can see which vendors are reliable

Background: reviews in database

  Given the following accounts exist:
    |  user_id  | name              | email              | password |
    |  1     | John Doe          | jd1234@columbia.edu     | Password1! |
    |  10    | Kathy Lee         | kl1234@barnard.edu    | Password1! |
    |  3     | Hannah Lasso      | hl1234@barnard.edu   | Password1! |
    |  4     | Barbara Reddington| br1234@barnard.edu  | Password1! |
    |  11    | Janine Abbott     | ja1234@columbia.edu   | Password1! |

  Given the following reviews exist:
    | client_id | vendor_id | vendor_name          | title      | rating | comment                                                  | reviewer | client_name |
    | 1          | 3          | Hannah Lasso         | Furniture  | 4      | Personally delivered to me.                             | client  | John Doe |
    | 2          | 3          | Hannah Lasso         | Furniture  | 3      | My chair had a scratch on the back.                     | client  | Kathy Lee |
    | 5          | 3          | Hannah Lasso         | Furniture  | 5      | Was really friendly.                                    | client  | Janine Abbott |
    | 4          | 3          | Hannah Lasso         | Furniture  | 5      | Sold at a really good price                             | client  | Barbara Reddington |
    | 1          | 4          | Barbara Reddington   | Manicure   | 1      | The nail design was not like the picture I showed.      | client  | John Doe |
    | 4          | 1          | John Doe             | Haircut   | 2      | They were late to the appointment.                      | vendor  | Barbara Reddington |
    | 3          | 4          | Barbara Reddington   | Manicure   | 1      | They were so rude to me.                               | client  | Hannah Lasso |

  And I am on the login page
  And I login with "jd1234@columbia.edu" and "Password1!"


Scenario: Show all reviews
    Given I am on the review home page
    Then I should see comments like:
      | They were late to the appointment. |
      | Personally delivered to me         |
      | Sold at a really good price        |

Scenario: Show reviews for Barbara Reddington
    Given I am on the show_vendor_review page for 4
    Then I should see comments like:
      | They were so rude to me.                           |
      | The nail design was not like the picture I showed. |
    Given I am on the show_client_review page for 4
    Then I should see comments like:
      | They were late to the appointment. |


Scenario: Delete a review
  When I am on the review home page
  When I click on "Reviews I Wrote"
  When I delete the review "Hannah Lasso", "Furniture", "Personally delivered to me.", "4"
  Then I should see "Review deleted"

Scenario: Create a new review
  Given I am on the new review page
  When I select the reviewer type as "Client"
  And I select the user being reviewed as "John Doe"
  And I fill in the service provided with "Lion Help!"
  And I fill in the review content with "Great service!"
  And I fill in the review rating with "4"
  And I submit the new review
  Then I should see the review success message

Scenario: Create a review with empty fields
  Given I am on the new review page
  And I submit the new review
  Then I should be on new review page

Scenario: I rate too high
  Given I am on the new review page
  When I select the reviewer type as "Client"
  And I select the user being reviewed as "John Doe"
  And I fill in the service provided with "Lion Help!"
  And I fill in the review content with "Great service!"
  And I fill in the review rating with "20"
  And I submit the new review
  Then I should see notice "Rating is too high."
  Then I should be on new review page

Scenario: I rate too low
  Given I am on the new review page
  When I select the reviewer type as "Client"
  And I select the user being reviewed as "John Doe"
  And I fill in the service provided with "Lion Help!"
  And I fill in the review content with "Great service!"
  And I fill in the review rating with "-10"
  And I submit the new review
  Then I should see notice "Rating is too low."
  Then I should be on new review page

Scenario: I edit a review
  When I am on the review home page
  When I click on "Reviews I Wrote"
  Then I should see "The nail design was not like the picture I showed."
  Then I should not see "Sold at a really good price"
  When I edit the review with comment: "The nail design was not like the picture I showed."
  And I fill in the review rating with "10"
  And I fill in the review content with "Second time around and the service was great!"
  And I press "Update"
  Then I should see "Second time around and the service was great!"
  Then I should not see "The nail design was not like the picture I showed."

Scenario: I edit a review with bad ratings
  When I am on the review home page
  When I click on "Reviews I Wrote"
  When I edit the review with comment: "The nail design was not like the picture I showed."
  And I fill in the review rating with "-10"
  And I press "Update"
  Then I should see "Rating is too low."
  And I fill in the review rating with "11"
  And I press "Update"
  Then I should see "Rating is too high."

Scenario: Show all reviews for John Doe and create a review as a vendor
  # Show reviews about John Doe
  Given I am on the show_vendor_review page for 1
  Then I should see comments like:
    | They were late to the appointment. |

  Given I am on the show_client_review page for 1
  Then I should see comments like:
    | Personally delivered to me         |
    | Sold at a really good price        |

  Given I am on the new review page
  When I select the reviewer type as "Client"     
  And I select the user being reviewed as "John Doe"
  And I fill in the service provided with "Haircut"
  And I fill in the review content with "Prompt and professional!"
  And I fill in the review rating with "5"
  And I submit the new review
  Then I should see the review success message

  Given I am on the show_client_review page for 1
  Then I should see comments like:
    | Prompt and professional! |

