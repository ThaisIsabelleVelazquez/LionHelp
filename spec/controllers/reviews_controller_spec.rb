require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:client) { UserAccount.create!(name: "ClientUser", email: "cu1234@columbia.edu", password: "Password1!") }
  let!(:vendor) { UserAccount.create!(name: "VendorUser", email: "vu1234@barnard.edu", password: "Password1!") }
  
  let!(:review_by_client) do
    Review.create!(
      client_name: client.name,
      vendor_name: vendor.name,
      title: "Great service",
      rating: 8,
      comment: "Very helpful",
      reviewer: "client"
    )
  end

  let!(:review_by_vendor) do
    Review.create!(
      client_name: client.name,
      vendor_name: vendor.name,
      title: "Good client",
      rating: 9,
      comment: "Easy to work with",
      reviewer: "vendor"
    )
  end

  before do
    session[:user_name] = client.name
  end

  describe "GET #index" do
    it "returns all reviews without filter" do
      get :index
      expect(assigns(:reviews)).to include(review_by_client, review_by_vendor)
      expect(response).to have_http_status(:ok)
    end

    it "filters reviews written by client" do
      get :index, params: { filter: "client" }
      expect(assigns(:reviews)).to include(review_by_client)
      expect(assigns(:reviews)).not_to include(review_by_vendor)
    end

    it "filters reviews written by vendor" do
      get :index, params: { filter: "vendor" }
      expect(assigns(:reviews)).to include(review_by_vendor)
      expect(assigns(:reviews)).not_to include(review_by_client)
    end
  end

  describe "POST #create" do
    it "creates a review successfully" do
      post :create, params: { review: {
        client_name: client.name,
        vendor_name: vendor.name,
        title: "Awesome",
        rating: 7,
        comment: "Nice job",
        reviewer: "client"
      } }

      expect(flash[:notice]).to eq("Review posted successfully!")
      expect(response).to redirect_to(reviews_path)
      expect(Review.last.title).to eq("Awesome")
    end

    it "rejects review with rating > 10" do
      post :create, params: { review: {
        client_name: client.name,
        vendor_name: vendor.name,
        title: "Bad rating",
        rating: 15,
        comment: "Too high",
        reviewer: "client"
      } }

      expect(flash[:notice]).to eq("Rating is too high.")
      expect(response).to redirect_to(new_review_path)
    end

    it "rejects review with rating < 0" do
      post :create, params: { review: {
        client_name: client.name,
        vendor_name: vendor.name,
        title: "Bad rating",
        rating: -2,
        comment: "Too low",
        reviewer: "client"
      } }

      expect(flash[:notice]).to eq("Rating is too low.")
      expect(response).to redirect_to(new_review_path)
    end
  end

  describe "DELETE #destroy" do
    it "allows author to delete their review" do
      # Client deletes their own review
      session[:user_name] = review_by_client.client_name

      delete :destroy, params: { id: review_by_client.id }

      expect(flash[:notice]).to eq("Review deleted")
      expect(Review.exists?(review_by_client.id)).to be_falsey
    end

    it "prevents non-author from deleting review" do
      # Client tries to delete vendor review
      session[:user_name] = client.name

      delete :destroy, params: { id: review_by_vendor.id }

      expect(flash[:alert]).to eq("You can only delete your own reviews.")
      expect(Review.exists?(review_by_vendor.id)).to be_truthy
    end
  end
end
