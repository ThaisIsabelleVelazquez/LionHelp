require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:vendor1) { UserAccount.create!(name: 'John Doe', email: 'jd1234@columbia.edu', password: 'Password1!') }
  let!(:vendor2) { UserAccount.create!(name: 'Jane Smith', email: 'jd1234@barnard.edu', password: 'Password1!') }
  let!(:client1) { UserAccount.create!(name: 'Alice Johnson', email: 'aj1234@barnard.edu', password: 'Password1!') }
  let!(:client2) { UserAccount.create!(name: 'Bob Lee', email: 'bl1234@columbia.edu', password: 'Password1!') }

  describe '.vendor_reviews' do
    it 'returns blank when vendor_id does not exist' do
      expect(Review.vendor_reviews(999)).to be_empty
    end

    it 'returns the correct reviews for a vendor' do
      review1 = Review.create!(
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        client_id: client1.id,
        client_name: client1.name,
        title: 'Tutoring',
        rating: 5,
        comment: 'The best tutor I’ve ever had.',
        reviewer: 'client'
      )

      review2 = Review.create!(
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        client_id: client2.id,
        client_name: client2.name,
        title: 'Manicure',
        rating: 5,
        comment: 'My nails look amazing!',
        reviewer: 'client'
      )

      review3 = Review.create!(
        vendor_id: vendor2.id,
        vendor_name: vendor2.name,
        client_id: client1.id,
        client_name: client1.name,
        title: 'Facial',
        rating: 4,
        comment: 'Relaxing experience.',
        reviewer: 'client'
      )

      expect(Review.vendor_reviews(vendor1.id)).to contain_exactly(review1, review2)
      expect(Review.vendor_reviews(vendor1.id)).not_to include(review3)
    end
  end

  describe '.client_reviews' do
    it 'returns blank when client_id does not exist' do
      expect(Review.client_reviews(999)).to be_empty
    end

    it 'returns the correct reviews for a client' do
      review4 = Review.create!(
        client_id: client1.id,
        client_name: client1.name,
        vendor_id: vendor2.id,
        vendor_name: vendor2.name,
        title: 'Tutoring',
        rating: 5,
        comment: 'Great student',
        reviewer: 'vendor'
      )

      review5 = Review.create!(
        client_id: client1.id,
        client_name: client1.name,
        vendor_id: vendor2.id,
        vendor_name: vendor2.name,
        title: 'Manicure',
        rating: 5,
        comment: 'On time',
        reviewer: 'vendor'
      )

      review6 = Review.create!(
        client_id: client2.id,
        client_name: client2.name,
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        title: 'Facial',
        rating: 4,
        comment: 'Good client',
        reviewer: 'vendor'
      )

      expect(Review.client_reviews(client1.id)).to contain_exactly(review4, review5)
      expect(Review.client_reviews(client1.id)).not_to include(review6)
    end
  end

  describe 'validations' do
    it 'validates presence of vendor_name for vendor reviews' do
      review = Review.new(
        vendor_id: vendor1.id,
        title: 'Test',
        rating: 5,
        comment: 'Test comment',
        reviewer: 'client',
        client_id: client1.id,
        client_name: client1.name
      )
      expect(review).not_to be_valid
      expect(review.errors[:vendor_name]).to include("Vendor not found")
    end

    it 'validates presence of client_name for client reviews' do
      review = Review.new(
        client_id: client1.id,
        title: 'Test',
        rating: 5,
        comment: 'Test comment',
        reviewer: 'vendor',
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        client_name: 'Nonexistent Client'
      )
      expect(review).not_to be_valid
      expect(review.errors[:client_name]).to include("Client not found")
    end

    it 'validates rating is between 0 and 10' do
      review = Review.new(
        client_id: client1.id,
        client_name: client1.name,
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        title: 'Test',
        rating: 11,
        comment: 'Invalid rating',
        reviewer: 'vendor'
      )
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("must be between 0 and 10")
    end

    it "validates reviewer is either 'client' or 'vendor'" do
      review = Review.new(
        client_id: client1.id,
        client_name: client1.name,
        vendor_id: vendor1.id,
        vendor_name: vendor1.name,
        title: 'Test',
        rating: 5,
        comment: 'Invalid reviewer',
        reviewer: 'other'
      )
      expect(review).not_to be_valid
      expect(review.errors[:reviewer]).to include("is not included in the list")
    end
  end
end
