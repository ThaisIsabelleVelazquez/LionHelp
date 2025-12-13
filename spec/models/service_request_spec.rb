require 'rails_helper'

RSpec.describe ServiceRequest, type: :model do
  let(:client) do
    UserAccount.create!(
      name: "Alice",
      email: "al1234@columbia.edu",
      password: "Password1!"
    )
  end

  let(:vendor) do
    UserAccount.create!(
      name: "Bob",
      email: "bo1234@columbia.edu",
      password: "Password1!"
    )
  end

  let(:service) do
    Service.create!(
      title: "Test Service",
      vendor_id: vendor.id,
      vendor_name: vendor.name,
      price: 50,
      description: "Desc",
      category: "Other"
    )
  end

  describe "validations" do
    it "is valid with all attributes" do
      sr = ServiceRequest.new(client: client, vendor: vendor, service: service, message: "Please help", status: "pending")
      expect(sr).to be_valid
    end

    it "is invalid without a client" do
      sr = ServiceRequest.new(vendor: vendor, service: service, message: "Help", status: "pending")
      expect(sr).not_to be_valid
      expect(sr.errors[:client]).to include("can't be blank")
    end

    it "is invalid without a vendor" do
      sr = ServiceRequest.new(client: client, service: service, message: "Help", status: "pending")
      expect(sr).not_to be_valid
      expect(sr.errors[:vendor]).to include("can't be blank")
    end

    it "is invalid without a message" do
      sr = ServiceRequest.new(client: client, vendor: vendor, service: service, message: "", status: "pending")
      expect(sr).not_to be_valid
      expect(sr.errors[:message]).to include("can't be blank")
    end
  end

end
