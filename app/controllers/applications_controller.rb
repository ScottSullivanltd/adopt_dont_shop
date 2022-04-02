class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash.now[:notice] = "Required Information missing, must complete all form fields."
      render :new
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode)
  end
end
