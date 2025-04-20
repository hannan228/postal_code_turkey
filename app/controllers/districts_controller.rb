class DistrictsController < ApplicationController
  protect_from_forgery except: :neighborhoods # Same security setup as provinces
  
  def neighborhoods
    @neighborhoods = District.find(params[:id]).neighborhoods
    respond_to do |format|
      format.js # Will render app/views/districts/neighborhoods.js.erb
    end
  end
end
