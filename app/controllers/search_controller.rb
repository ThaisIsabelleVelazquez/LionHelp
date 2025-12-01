class SearchController < ApplicationController
  
  def reviews
    @query = params[:q]
    @search = Review.ransack(title_or_comment_or_client_name_or_vendor_name_cont: @query)
    @results = @search.result
  end

  def services
    @query = params[:q]
    @search = Service.ransack(title_or_description_or_vendor_name_cont: @query)
    @results = @search.result
  end

end
