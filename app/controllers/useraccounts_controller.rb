class UseraccountsController < ApplicationController
  def show
    @user = UserAccount.find(params[:id])

    @services = Service.where(vendor_name: @user.name)
    @vendor_reviews = Review.vendor_reviews(@user.id)
    @client_reviews = Review.client_reviews(@user.id)
  end
end
