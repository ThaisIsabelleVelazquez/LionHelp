Given(/the following accounts exist/) do |accounts_table|
  accounts_table.hashes.each do |account|
      UserAccount.create!(account)
  end
end

And("I am on the login page") do
  visit accounts_path
end

Then('I should be on login page') do
  visit accounts_path
end

Then('I should be on signup page') do
  visit new_account_path
end

And('I sign up with the following: name as {string}, email as {string}, password as {string}') do |name, email, password|
  fill_in 'Name', with: name
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Create'
end

When('I login with {string} and {string}') do |email, password|
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Login'
end

When('I go to create an account') do
  click_link 'Create an Account'
end

When('I click Logout') do
  click_link 'Logout'
end

When('I visit the profile page for {string}') do |name|
  user = UserAccount.find_by(name: name)
  visit profile_path
end

Then('I should see my email {string}') do |name|
  expect(page).to have_content(name)
end

Then('I should see my service {string}') do |service_title|
  expect(page).to have_content(service_title)
end

Then('I should see a review as vendor {string}') do |review_comment|
  expect(page).to have_content(review_comment)
end

Then('I should see a review as client {string}') do |review_comment|
  expect(page).to have_content(review_comment)
end


When('I visit the profile page of vendor {string}') do |vendor_name|
  vendor = UserAccount.find_by(name: vendor_name)
  visit useraccount_path(vendor)  # Goes to /useraccounts/:id
end

Then('I should see a review as the client {string}') do |review_comment|
  expect(page).to have_content(review_comment)
end

Then('I should see the vendor service {string}') do |service_title|
  expect(page.text).to include(service_title.strip)
end



