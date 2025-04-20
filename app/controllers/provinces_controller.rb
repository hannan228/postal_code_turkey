class ProvincesController < ApplicationController
  protect_from_forgery except: :districts # Only for this action
  after_action :allow_iframe, only: :districts

  def districts
    @districts = Province.find(params[:id]).districts
    respond_to do |format|
      format.js
    end
  end

  private

  def allow_iframe
    response.headers.delete('X-Frame-Options')
    response.headers['X-Content-Type-Options'] = 'nosniff'
  end
end