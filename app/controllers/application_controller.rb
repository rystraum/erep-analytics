class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_countries
  def get_countries
    @countries = Country.all
    @mercs = Merchandise.find :all, order: "erep_item_code, quality"
  end
end

