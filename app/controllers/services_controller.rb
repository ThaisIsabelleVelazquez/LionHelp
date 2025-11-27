class ServicesController < ApplicationController
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
  
    private
  
    def service_params
      params.require(:service).permit(:title, :description, :price, :vendor_id, :vendor_name, :category)
    end
  end
  