class UseraccountsController < ApplicationController
  def show
    @user = UserAccount.find(params[:id])

    @services = Service.where(vendor_name: @user.name)

    @vendor_reviews = Review
      .where("LOWER(vendor_name) = ?", @user.name.downcase.strip)
      .where(reviewer: 'client')
      .where.not(rating: nil)

    service_averages = @vendor_reviews.group_by(&:title).map do |_, reviews|
      reviews.sum { |r| r.rating.to_f } / reviews.size
    end

    @vendor_average_rating =
      service_averages.any? ? (service_averages.sum / service_averages.size) : 0

    @client_reviews = Review
      .where("LOWER(client_name) = ?", @user.name.downcase.strip)
      .where(reviewer: 'vendor')
      .where.not(rating: nil)

    @client_average_rating = (
      @client_reviews.any? ?
        @client_reviews.sum { |r| r.rating.to_f } / @client_reviews.size :
        0
    )
  end
end
