class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    Application.update(params[:id], application_params)

    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def application_params
    params.permit(:status, :description, :name, :street_address, :city, :state, :zipcode)
  end
end
