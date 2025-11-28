require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:valid_attributes) { { title: "Laundry Help", description: "Fold laundry", price: 15, vendor_name: "Emily", category: "Tutoring" } }

  it 'is valid with all attributes' do
    expect(Service.new(valid_attributes)).to be_valid
  end

  it 'is invalid without a title' do
    service = Service.new(valid_attributes.except(:title))
    expect(service).not_to be_valid
    expect(service.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    service = Service.new(valid_attributes.except(:description))
    expect(service).not_to be_valid
    expect(service.errors[:description]).to include("can't be blank")
  end

  it 'is invalid without a poster' do
    service = Service.new(valid_attributes.except(:vendor_name))
    expect(service).not_to be_valid
    expect(service.errors[:vendor_name]).to include("can't be blank")
  end

  it 'is invalid with negative price' do
    service = Service.new(valid_attributes.merge(price: -5))
    expect(service).not_to be_valid
    expect(service.errors[:price]).to include("must be greater than or equal to 0")
  end
end
