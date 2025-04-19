class PostalCodeSearch
  def self.call(params)
    PostalCode.joins(:neighborhood => [:district => :province])
              .then { |scope| filter_by_province(scope, params[:province_id]) }
              .then { |scope| filter_by_district(scope, params[:district_id]) }
  end

  private_class_method def self.filter_by_province(scope, province_id)
    province_id ? scope.where(provinces: { id: province_id }) : scope
  end
end