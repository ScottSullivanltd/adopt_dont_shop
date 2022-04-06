class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pet_applications
    # @pets = @application.pets
  end

  def update
    if params[:approve]
      @application = Application.find(params[:id])
      @pet_application = @application.pet_applications.where(pet_id: params[:pet_id], application_id: @application.id)
      @pet_application.update(status: "Approved")
    elsif params[:reject]
      @application = Application.find(params[:id])
      @pet_application = @application.pet_applications.where(pet_id: params[:pet_id], application_id: @application.id)
      @pet_application.update(status: "Rejected")
    end
    #@pet_application.save
    redirect_to "/admin/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:status, :description, :name, :street_address, :city, :state, :zipcode)
  end
end
