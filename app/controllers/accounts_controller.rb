class AccountsController < ApplicationController
  
def profile
  @user = UserAccount.find_by(id: session[:user_id])

  unless @user
    redirect_to accounts_path, notice: "You must be logged in."
    return
  end

  @services = Service.where(vendor_name: @user.name)

  @vendor_reviews = Review
    .where("LOWER(vendor_name) = ?", @user.name.downcase.strip)
    .where(reviewer: 'client')
    .where.not(rating: nil)

  @vendor_average_rating =
    @vendor_reviews.any? ?
      (@vendor_reviews.sum { |r| r.rating.to_f } / @vendor_reviews.size).round(2) :
      0


  @client_reviews = Review
    .where("LOWER(client_name) = ?", @user.name.downcase.strip)
    .where(reviewer: 'vendor')
    .where.not(rating: nil)

  @client_average_rating =
    @client_reviews.any? ?
      (@client_reviews.sum { |r| r.rating.to_f } / @client_reviews.size).round(2) :
      0
end

  
  def index
    current_user = UserAccount.find_by(name: session[:user_name])
    if current_user
      redirect_to services_path
    end
  end

  def login
    email = account_params[:email]
    password = account_params[:password]

    user = UserAccount.find_by(email: email)
    if user.nil?
      flash[:notice] = "No account found with that email."
      redirect_to accounts_path
    elsif user.password != password
      flash[:notice] = "Incorrect password."
      redirect_to accounts_path
    else
      # added 
      session[:user_id] = user.id 
      session[:user_name] = user.name
      redirect_to services_path
    end
  end

  def logout
    session.delete(:user_name)
    redirect_to accounts_path
  end

  def create
    email = account_params[:email]
    existing_user = UserAccount.find_by(email: email)
    if !existing_user.nil?
      flash[:notice] = "An account with this email already exists."
      redirect_to new_account_path
    elsif !email.match(/^[A-Za-z]{2,3}\d{4}@(columbia|barnard).edu$/)
      flash[:notice] = "This is not a valid Columbia/Barnard email address. Note that a UNI is 2 or 3 letters followed by 4 digits."
      redirect_to new_account_path
    else
      user = UserAccount.new(account_params)
      if user.save
        session[:user_name] = user.name
        redirect_to services_path
      else
        if user.errors[:password].any?
          flash[:notice] = "Must be a strong password (at least 8 characters, includes uppercase, lowercase, number, and special character)"
        else
          flash[:notice] = "Error creating account. Please try again."
        end
        redirect_to new_account_path
      end
    end
  end

  def account_params
    params.require(:user_account).permit(:name, :email, :password)
  end
end