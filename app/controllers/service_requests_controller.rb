class ServiceRequestsController < ApplicationController
    before_action :set_service_request, only: [:update]
    before_action :require_login
  
    def new
      @service_request = ServiceRequest.new(
        service_id: params[:service_id],
        vendor_id: params[:vendor_id]
      )
    end
  
    def create
      client = UserAccount.find_by(name: session[:user_name])
      
      @service_request = ServiceRequest.new(service_request_params)
      @service_request.client = client
      @service_request.status = "pending"
  
      if @service_request.save
        redirect_to inbox_service_requests_path, notice: "Request sent!"
      else
        flash.now[:alert] = "Unable to send request."
        render :new
      end
    end
  
    def inbox
      vendor = UserAccount.find_by(name: session[:user_name])
      @requests = ServiceRequest
                    .where(vendor: vendor)
                    .order(created_at: :desc)
    end
  
    def update
      if params[:accept]
        @service_request.update(status: "accepted")
      elsif params[:decline]
        @service_request.update(status: "declined")
      end
  
      redirect_to inbox_service_requests_path, notice: "Request updated"
    end
  
    private
  
    def service_request_params
      params.require(:service_request).permit(:vendor_id, :service_id, :message)
    end
  
    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to inbox_service_requests_path, alert: "Request not found"
    end
  end
  