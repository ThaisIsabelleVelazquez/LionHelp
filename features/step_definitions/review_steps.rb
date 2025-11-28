Given(/the following reviews exist/) do |reviews_table|
    reviews_table.hashes.each do |review|
        Review.create review
    end
end

Given('I am on the review home page') do
    visit reviews_path
end

Given(/^I am on the new review page$/) do
  visit new_review_path
end

Given('I am on the show_vendor_review page for {int}') do |vendor_id|
    puts "Visiting path: #{vendor_reviews_path(vendor_id)}"
    visit vendor_reviews_path(vendor_id)
end

Given('I am on the show_client_review page for {int}') do |client_id|
  puts "Visiting path: #{client_reviews_path(client_id)}"
  visit client_reviews_path(client_id)
end


Then(/^I should see comments like:/) do |comment_table|
    comment_table.raw.flatten.each do |comment|
      expect(page).to have_content(comment)
    end
end

Then('I should see notice {string}') do |notice|
  expect(page).to have_content(notice)
end

Given('the following review exists:') do |table|
  table.hashes.each do |row|
    client = UserAccount.find_by(name: row['client_name']) || UserAccount.first
    vendor = UserAccount.find_by(name: row['vendor_name'])

    Review.create!(
      client_id: client.id,
      vendor_id: vendor.id,
      vendor_name: vendor.name,
      client_name: client.name,
      title: row['title'],
      rating: row['rating'],
      comment: row['comment'],
      reviewer: row['reviewer'] || 'client'
    )
  end
end

When('I delete the review {string}, {string}, {string}, {string}') do |vendor_name, title, comment, rating|
  review = Review.find_by(
    vendor_name: vendor_name,
    title: title,
    comment: comment,
    rating: rating.to_i
  )
  click_link "review-#{review.id}-delete"
end

When('I edit the review with comment: {string}') do | comment |
  review = Review.find_by(comment: comment)
  puts Review.all.pluck(:vendor_name, :title, :comment, :rating)
  puts review.inspect
  click_link "review-#{review.id}-edit"
end

When('I click on {string}') do | title |
  click_on title
end

When(/^I select "([^"]*)" from "([^"]*)"$/) do |option, field|
  select(option, from: field)
end

Given("I am on the review page") do
  visit new_review_path
end

Then("I should be on new review page") do
  visit new_review_path
end

When(/^I select the reviewer type as "([^"]+)"$/) do |type|
  select type, from: "review_type"
end

When(/^I select the user being reviewed as "([^"]+)"$/) do |user_name|
  select user_name, from: "reviewed_name"
end

When(/^I fill in the service provided with "([^"]+)"$/) do |title|
  fill_in "service_provided", with: title
end

When(/^I fill in the review content with "([^"]+)"$/) do |content|
  fill_in "review_comment", with: content
end

When(/^I fill in the review rating with "([^"]+)"$/) do |rating|
  fill_in "review_rating", with: rating
end

When(/^I submit the new review$/) do
  click_button "Create Review"
end

Then(/^I should see the review success message$/) do
  expect(page).to have_content("Review posted successfully!")
end
