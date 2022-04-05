class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
    @pending_apps = Shelter.pending_applications
  end
end
