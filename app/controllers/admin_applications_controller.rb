class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @application_pets = @application.application_pets
    # @pets = @application.pets
  end

  def update
    if params[:approve]
      @application = Application.find(params[:id])
      @application_pets = @pet_application.where(params[:pet_id])
      @application.update(status: "Approved")
      @application.save
      redirect_to "/admin/applications/#{@application.id}"
    end
  end

  private

  def application_params
    params.permit(:status, :description, :name, :street_address, :city, :state, :zipcode)
  end
end
