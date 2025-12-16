require 'rails_helper'

RSpec.describe ServiceRequestsController, type: :controller do
  let!(:client) do
    UserAccount.create!(user_id: 1, name: "Alice", email: "al1234@columbia.edu", password: "Password1!")
  end

  let!(:vendor) do
    UserAccount.create!(user_id: 2, name: "Bob", email: "bb5678@columbia.edu", password: "Password1!")
  end

  let!(:service) do
    Service.create!(
      title: "Test Service",
      vendor_id: vendor.user_id,
      vendor_name: vendor.name,
      price: 50,
      description: "Desc",
      category: "Other"
    )
  end

  before do
    # Simulate logged-in user
    # allow(controller).to receive(:session).and_return({ user_name: client.name })
    session[:user_name] = client.name
    allow(controller).to receive(:require_login).and_return(true)
  end

  describe "POST #create" do
    it "creates a new service request" do
      # session[:user_name] = client.name
      expect {
        post :create, params: { service_request: { service_id: service.id, vendor_id: vendor.user_id, message: "Please help" } }
      }.to change(ServiceRequest, :count).by(1)

      sr = ServiceRequest.last
      expect(sr.client).to eq(client)
      expect(sr.vendor_id).to eq(vendor.id)
      expect(sr.status).to eq("pending")
      expect(response).to redirect_to(inbox_service_requests_path)
    end
      
  end

  describe "PATCH #update" do
    let!(:service_request) do
      ServiceRequest.create!(client: client, vendor_id: vendor.id, service: service, message: "Pending request", status: "pending")
    end

    it "accepts a request" do
      patch :update, params: { id: service_request.id, accept: true }
      expect(service_request.reload.status).to eq("accepted")
      expect(response).to redirect_to(inbox_service_requests_path)
    end

    it "declines a request" do
      patch :update, params: { id: service_request.id, decline: true }
      expect(service_request.reload.status).to eq("declined")
      expect(response).to redirect_to(inbox_service_requests_path)
    end

    it "redirects with alert if request not found" do
      patch :update, params: { id: 999, accept: true }
      expect(response).to redirect_to(inbox_service_requests_path)
      expect(flash[:alert]).to eq("Request not found")
    end
  end
end
