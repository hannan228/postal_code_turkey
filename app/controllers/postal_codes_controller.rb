class PostalCodesController < ApplicationController

  def index
    @provinces = Province.all
    
    @postal_codes = if params[:neighborhood_id].present?
                      PostalCode.where(neighborhood_id: params[:neighborhood_id])
                    elsif params[:district_id].present?
                      PostalCode.joins(:neighborhood)
                              .where(neighborhoods: { district_id: params[:district_id] })
                    elsif params[:province_id].present?
                      PostalCode.joins(neighborhood: :district)
                              .where(districts: { province_id: params[:province_id] })
                    else
                      PostalCode.none # Or .all.limit(50) for default display
                    end
  end

  # For AJAX dropdowns
  def districts
    @districts = Province.find(params[:province_id]).districts
    print "fffffffff"
    respond_to do |format|
      format.js
    end
  end

  def neighborhoods
    @neighborhoods = District.find(params[:district_id]).neighborhoods
    respond_to do |format|
      format.js
    end
  end
end