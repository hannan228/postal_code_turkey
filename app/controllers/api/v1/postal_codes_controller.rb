class Api::V1::PostalCodesController < ApplicationController
  before_action :set_locale

  def index
    @postal_codes = PostalCode.includes(:neighborhood => [:district => :province])
    render json: @postal_codes, 
           include: { neighborhood: { include: { district: { include: :province } } }
  end

  def search
    @postal_codes = PostalCode.where(code: params[:code])
    render json: @postal_codes
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end