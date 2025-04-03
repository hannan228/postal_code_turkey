class PostalCode < ApplicationRecord
  belongs_to :neighborhood
  delegate :district, :province, to: :neighborhood
  
  validates :code, format: { 
    with: /\A\d{5}\z/, 
    message: "must be 5 digits" 
  }
end
