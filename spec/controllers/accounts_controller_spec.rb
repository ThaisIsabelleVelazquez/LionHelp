require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  
  describe "GET #index" do
    it "redirects to services when user is logged in" do
        UserAccount.create!(
        name: "Kristine",
        email: "kp2157@columbia.edu",
        password: "Password1!"
        )
    
        session[:user_name] = "Kristine"
    
        get :index
        expect(response).to redirect_to(services_path)
    end

    it "renders successfully when not logged in" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end


  describe "POST #login" do
    before do
      @user = UserAccount.create!(
        name: "Kristine",
        email: "kp2157@columbia.edu",
        password: "Password1!"
      )
    end

    it "logs in with correct credentials" do
      post :login, params: {
        user_account: {
          email: @user.email,
          password: "Password1!"
        }
      }

      expect(session[:user_name]).to eq("Kristine")
      expect(session[:user_id]).to eq(@user.id)
      expect(response).to redirect_to(services_path)
    end

    it "shows error if user not found" do
      post :login, params: {
        user_account: { email: "nope@columbia.edu", password: "Password1!" }
      }

      expect(flash[:notice]).to eq("No account found with that email.")
      expect(response).to redirect_to(accounts_path)
    end

    it "shows error for incorrect password" do
      post :login, params: {
        user_account: {
          email: @user.email,
          password: "Wrong123!"
        }
      }

      expect(flash[:notice]).to eq("Incorrect password.")
      expect(response).to redirect_to(accounts_path)
    end
  end


  describe "POST #create" do
    it "rejects if email already exists" do
      UserAccount.create!(
        name: "Test",
        email: "ab1234@columbia.edu",
        password: "Password1!"
      )

      post :create, params: {
        user_account: {
          name: "New User",
          email: "ab1234@columbia.edu",
          password: "Password1!"
        }
      }

      expect(flash[:notice]).to eq("An account with this email already exists.")
      expect(response).to redirect_to(new_account_path)
    end

    it "rejects invalid Columbia/Barnard email format" do
      post :create, params: {
        user_account: {
          name: "New User",
          email: "test@gmail.com",
          password: "Password1!"
        }
      }

      expect(flash[:notice]).to include("not a valid Columbia/Barnard email address")
      expect(response).to redirect_to(new_account_path)
    end

    it "rejects weak password" do
      post :create, params: {
        user_account: {
          name: "New User",
          email: "ab1234@columbia.edu",
          password: "weak"
        }
      }

      expect(flash[:notice]).to include("Must be a strong password")
      expect(response).to redirect_to(new_account_path)
    end

    it "creates a user and redirects on success" do
      post :create, params: {
        user_account: {
          name: "Strong User",
          email: "ab1234@columbia.edu",
          password: "Password1!"
        }
      }

      expect(session[:user_name]).to eq("Strong User")
      expect(response).to redirect_to(services_path)
    end
  end


  describe "GET #logout" do
    it "clears session and redirects" do
      session[:user_name] = "Someone"
      get :logout

      expect(session[:user_name]).to be_nil
      expect(response).to redirect_to(accounts_path)
    end
  end

end
