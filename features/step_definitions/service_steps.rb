Given('I am on the new service page') do
  visit new_service_path
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

When('I go to the service details page for {string}') do |title|
  service = Service.find_by(title: title)
  visit service_path(service)
end

When('I delete the service {string}') do |title|
  service = Service.find_by(title: title)
  visit service_path(service)
  click_link 'Delete'
end

Then('I should not see {string}') do |text|
  expect(page).not_to have_content(text)
end

Given('the following services exist:') do |table|
  table.hashes.each do |service|
    Service.create!(service)
  end
end

When('I go to the services page') do
  visit services_path
end
