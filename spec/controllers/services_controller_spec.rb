require 'rails_helper'

RSpec.describe ServicesController, type: :controller do

  let(:user) { UserAccount.create!(
    name: "Kristine Pham", 
    email: "klp2157@barnard.edu", 
    password: "password") 
  }

  let(:valid_attributes) do
    {
      title: "Laundry Help",
      description: "Fold and organize laundry",
      price: 15.00,
      vendor_name: "Emily",
      category: "Cleaning"
    }
  end

  let(:invalid_missing_title) { valid_attributes.except(:title) }
  let(:invalid_missing_description) { valid_attributes.except(:description) }
  let(:invalid_missing_vendor_name) { valid_attributes.except(:vendor_name) }
  let(:invalid_negative_price) { valid_attributes.merge(price: -5) }

  before do
    session[:user_name] = user.name
  end

  describe "GET #index" do
    it "assigns all services and renders index" do
      service = Service.create!(valid_attributes)
      get :index
      expect(assigns(:services)).to include(service)
      expect(response).to render_template(:index)
    end
    context "with category filter" do
      let!(:service_food) { Service.create!(title: "Pizza Delivery", description: "Late night snacks", price: 10, vendor_name: "Bob", category: "Food") }
      let!(:service_tutoring) { Service.create!(title: "Tutoring", description: "Math help", price: 20, vendor_name: "Alice", category: "Tutoring") }
    
      it "returns only services matching the selected category" do
        get :index, params: { category: "Food" }
        expect(assigns(:services)).to eq([service_food])
      end
    
      it "returns all services if category is 'All'" do
        get :index, params: { category: "All" }
        expect(assigns(:services)).to include(service_food, service_tutoring)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new service and renders new" do
      get :new
      expect(assigns(:service)).to be_a_new(Service)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new service and redirects to show page" do
        expect {
          post :create, params: { service: valid_attributes }
        }.to change(Service, :count).by(1)

        expect(response).to redirect_to(Service.last)
        expect(flash[:notice]).to eq("Service created successfully!")
      end
    end

    context "with missing title" do
      it "does not create service and re-renders new" do
        expect {
          post :create, params: { service: invalid_missing_title }
        }.not_to change(Service, :count)

        expect(response).to render_template(:new)
        expect(assigns(:service).errors[:title]).to include("can't be blank")
      end
    end

    context "with missing description" do
      it "does not create service and re-renders new" do
        expect {
          post :create, params: { service: invalid_missing_description }
        }.not_to change(Service, :count)

        expect(response).to render_template(:new)
        expect(assigns(:service).errors[:description]).to include("can't be blank")
      end
    end

    context "with missing vendor_name" do
      it "does not create service and re-renders new" do
        expect {
          post :create, params: { service: invalid_missing_vendor_name }
        }.not_to change(Service, :count)

        expect(response).to render_template(:new)
        expect(assigns(:service).errors[:vendor_name]).to include("can't be blank")
      end
    end

    context "with negative price" do
      it "does not create service and re-renders new" do
        expect {
          post :create, params: { service: invalid_negative_price }
        }.not_to change(Service, :count)

        expect(response).to render_template(:new)
        expect(assigns(:service).errors[:price]).to include("must be greater than or equal to 0")
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested service and renders show" do
      service = Service.create!(valid_attributes)
      get :show, params: { id: service.id }
      expect(assigns(:service)).to eq(service)
      expect(response).to render_template(:show)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the service and redirects to index" do
      service = Service.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: service.id }
      }.to change(Service, :count).by(-1)

      expect(flash[:notice]).to eq("Service '#{service.title}' deleted.")
      expect(response).to redirect_to(services_path)
    end
  end
end
