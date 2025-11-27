class ServicesController < ApplicationController
    before_action :require_login
    def new
      @service = Service.new
    end

    def index
      @user_name = session[:user_name]
      if params[:category].present? && params[:category] != "All"
        @services = Service.where(category: params[:category])
      else
        @services = Service.all
      end
    end
  
    def create
        @service = Service.new(service_params)
        if @service.save
          flash[:notice] = "Service created successfully!"
          redirect_to service_path(@service) 
        else
          render :new
        end
      end
  
    def show
      @service = Service.find(params[:id])
    end
  
    def destroy
      @service = Service.find(params[:id])
      @service.destroy
      flash[:notice] = "Service '#{@service.title}' deleted."
      redirect_to services_path
    end
  
    def user_services
      @services = Service.where(vendor_name: session[:user_name])
    end

    def edit
      @service = Service.find(params[:id])
    end

    def update
      @service = Service.find(params[:id])
      if service_params[:price].to_i < 0
        flash.now[:warning] = "Price is negative."
        render :edit
      elsif @service.update(service_params)
        flash[:notice] = "#{@service.title} was successfully updated."
        redirect_to service_path(@service)
      else
        flash[:notice] = "An error occured while updating #{@service.title}."
        render :edit
      end
    end

    private
  
    def service_params
      params.require(:service).permit(:title, :description, :price, :vendor_id, :vendor_name, :category)
    end
  end
  