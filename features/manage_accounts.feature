Feature: Using the app with an account
  As a Columbia student
  I can use with the app with an existing account
  Or I can create a new account

Background:
  Given the following accounts exist:
    | user_id    | name          | email             | password   |
    | 0          | Kathy Lee     | kl1234@barnard.edu   | Password1!   |
    | 1          | John Doe      | jd1234@columbia.edu    | Password1!   |
  
  Given the following services exist:
    | title          | description             | category   | price | vendor_name |
    | Math Tutoring  | Help with math          | Tutoring   | 50    | John Doe    |
    | Grocery Pickup | Pickup groceries        | Food       | 20    | Jane Smith  |
    | Dorm Cleaning  | Clean dorm rooms        | Cleaning   | 30    | Mike Lee    |
      
  Given the following reviews exist:
    | client_id | vendor_id | vendor_name   | title    | rating | comment                  | reviewer | client_name |
    | 1         | 2         | Hannah Lasso | Furniture | 4     | Prompt and professional! | client  | John Doe    |
    | 2         | 1         | John Doe     | Haircut   | 5     | Excellent haircut!       | vendor  | Hannah Lasso|
  
  
  
  And I am on the login page

Scenario: I have an account and I successfully login
  When I login with "jd1234@columbia.edu" and "Password1!"
  Then I should see "Welcome, John Doe"

Scenario: I attempt to login with empty fields
  When I login with "" and ""
  Then I should be on login page

Scenario: I attempt to login with empty email field
  When I login with "" and "Password1!"
  Then I should be on login page

Scenario: I attempt to login with empty password field
  When I login with "jd1234@columbia.edu" and ""
  Then I should be on login page

Scenario: I have an account and I use the wrong password
  When I login with "jd1234@columbia.edu" and "asdf"
  Then I should see "Incorrect password."
  Then I should be on login page

Scenario: I do not have an account and I attempt to login
  When I login with "ml1234@barnard.edu" and "Password1!"
  Then I should see "No account found with that email."
  Then I should be on login page

Scenario: I create an account with valid credentials
  When I go to create an account
  And I sign up with the following: name as "Kristine Pham", email as "klp1234@columbia.edu", password as "Password1!"
  Then I should see "Welcome, Kristine Pham"

Scenario: I create an account with non-Columbia/Barnard email
  When I go to create an account
  And I sign up with the following: name as "Kristine Pham", email as "k124@gmail.com", password as "Password1!"
  Then I should see "This is not a valid Columbia/Barnard email address."

Scenario: I attempt to create an account with empty fields
  When I go to create an account
  And I sign up with the following: name as "", email as "", password as ""
  Then I should be on signup page

Scenario: I attempt to create an account with empty name field
  When I go to create an account
  And I sign up with the following: name as "", email as "kl2157@barnard.edu", password as "Password1!"
  Then I should be on signup page

Scenario: I attempt to create an account with empty email field
  When I go to create an account
  And I sign up with the following: name as "Kristine Pham", email as "", password as "Password1!"
  Then I should be on signup page

Scenario: I attempt to create an account with empty password field
  When I go to create an account
  And I sign up with the following: name as "Kristine Pham", email as "klp2157@barnard.edu", password as ""
  Then I should be on signup page

Scenario: I create an account with an existing email
  When I go to create an account
  And I sign up with the following: name as "John Doe", email as "jd1234@columbia.edu", password as "Password1!"
  Then I should see "An account with this email already exists."
  Then I should be on signup page

Scenario: I logout and I am back to login page
  When I login with "jd1234@columbia.edu" and "Password1!"
  Then I should see "Welcome, John Doe"
  When I click Logout
  Then I should be on login page

Scenario: I access the app without logging in
  When I go to the services page
  Then I should see "Please log in to access the app."
  When I am on the new service page
  Then I should see "Please log in to access the app."
  When I am on the new review page
  Then I should see "Please log in to access the app."
  When I am on the review home page
  Then I should see "Please log in to access the app."

Scenario: I create an account with a weak password
  When I go to create an account
  And I sign up with the following: name as "Kristine", email as "kp1234@columbia.edu", password as "weakpassword"
  Then I should see "Must be a strong password (at least 8 characters, includes uppercase, lowercase, number, and special character)"
  Then I should be on signup page

Scenario: I create an account with a password missing uppercase letters
  When I go to create an account
  And I sign up with the following: name as "Kristine", email as "kp1234@columbia.edu", password as "password1!"
  Then I should see "Must be a strong password (at least 8 characters, includes uppercase, lowercase, number, and special character)"
  Then I should be on signup page

Scenario: I create an account with a password missing numbers
  When I go to create an account
  And I sign up with the following: name as "Kristine", email as "kp1234@columbia.edu", password as "Password!"
  Then I should see "Must be a strong password (at least 8 characters, includes uppercase, lowercase, number, and special character)"
  Then I should be on signup page

Scenario: I create an account with a password missing special characters
  When I go to create an account
  And I sign up with the following: name as "Kristine", email as "kp1234@columbia.edu", password as "Password1"
  Then I should see "Must be a strong password (at least 8 characters, includes uppercase, lowercase, number, and special character)"
  Then I should be on signup page


Scenario: View my own profile
  When I visit the profile page for "John Doe"
  When I login with "jd1234@columbia.edu" and "Password1!"
  When I visit the profile page for "John Doe"
  Then I should see my email "Email: jd1234@columbia.edu"
  And I should see my service "Math Tutoring"
  And I should see "Vendor Rating"
  And I should see "Client Rating"