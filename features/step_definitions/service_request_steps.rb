Given("the following users exist:") do |table|
    UserAccount.destroy_all
    table.hashes.each do |user|
      UserAccount.create!(
        name: user['name'],
        email: user['email'],
        password: user['password']
      )
    end
  end
  
  Given("the following services exist for service requests:") do |table|
    Service.destroy_all
    table.hashes.each do |service|
      vendor = UserAccount.find_by(name: service['vendor_name'])
      Service.create!(
        title: service['title'],
        vendor_name: service['vendor_name'],
        vendor_id: vendor.id,
        price: service['price'],
        description: service['description'],
        category: service['category']
      )
    end
  end
  
  Given("I am logged in as {string}") do |user_name|
    user = UserAccount.find_by(name: user_name)
    visit root_path  # Make sure we go to the login page first
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password # Use the actual password from table
    click_button "Login"
  end
  
  When("I send a request for {string} to {string} with message {string}") do |service_title, vendor_name, message|
    service = Service.find_by(title: service_title, vendor_name: vendor_name)
    visit new_service_request_path(service_id: service.id, vendor_id: service.vendor_id)
    fill_in "service_request[message]", with: message
    click_button "Send Request"
  end
  
  When("I attempt to send a request for {string} to {string} with message {string}") do |service_title, vendor_name, message|
    step "I send a request for \"#{service_title}\" to \"#{vendor_name}\" with message \"#{message}\""
  end
  
  Given("there is a pending request from {string} for {string}") do |client_name, service_title|
    client = UserAccount.find_by(name: client_name)
    service = Service.find_by(title: service_title)
    ServiceRequest.create!(
      client_id: client.id,
      vendor_id: service.vendor_id,
      service_id: service.id,
      status: "pending",
      message: "Pending request"
    )
  end
  
  When("I visit my inbox") do
    visit inbox_service_requests_path
  end
  
  Then("I should see {string} under {string}") do |text, section|
    section_id = case section
                 when "Incoming Pending" then "incoming_pending"
                 when "Incoming History" then "incoming_history"
                 when "Outgoing Requests" then "outgoing_requests"
                 else
                   section.parameterize(separator: '_')
                 end
    within("##{section_id}") do
      expect(page).to have_content(text)
    end
  end
  
  When("I accept the request from {string}") do |client_name|
    req = ServiceRequest.find_by(client: UserAccount.find_by(name: client_name))
    visit inbox_service_requests_path
    within("tr", text: client_name) do
      click_link "Accept"
    end
  end
  
  When("I decline the request from {string}") do |client_name|
    req = ServiceRequest.find_by(client: UserAccount.find_by(name: client_name))
    visit inbox_service_requests_path
    within("tr", text: client_name) do
      click_link "Decline"
    end
  end
  
  
  Then("the request status should be {string}") do |status|
    request = ServiceRequest.last
    expect(request.status).to eq(status)
  end
  