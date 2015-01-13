class LocationsController < ApplicationController
  # GET locations/:location_name
  def show
    render json: Location.search_by_name(params[:id])
  end
end

