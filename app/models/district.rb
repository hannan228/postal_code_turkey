class District < ApplicationRecord
  belongs_to :province
  has_many :neighborhoods
  has_many :postal_codes, through: :neighborhoods
  
end
