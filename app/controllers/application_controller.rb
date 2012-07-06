class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_countries
  layout :get_layout

  def get_layout
    request.xhr? ? nil : 'application'
  end

  def get_countries
    @countries = Country.all
    @mercs = Merchandise.find :all, order: "erep_item_code, quality"
  end
end

