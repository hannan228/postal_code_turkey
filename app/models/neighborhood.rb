class Neighborhood < ApplicationRecord
  belongs_to :district
  belongs_to :province
  has_many :postal_codes
  
  # Ensures province matches district's province
  before_validation :set_province, if: -> { district.present? }
  
  validate :province_matches_district

  private
  def set_province
    self.province ||= district.province
  end

  def province_matches_district
    if province != district.province
      errors.add(:province, "must match district's province")
    end
  end
end
