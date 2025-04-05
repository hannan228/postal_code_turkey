class Province < ApplicationRecord
  has_many :districts
  has_many :neighborhoods
  has_many :postal_codes, through: :neighborhoods
  
  before_validation :generate_slug
  validates :slug, uniqueness: true
  
  private
  def generate_slug
    self.slug = name.parameterize
  end
end
