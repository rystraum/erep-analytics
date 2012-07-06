class MarketPostsController < ApplicationController
  respond_to :html, :json
  def filter
    @merc = Merchandise.find_by_id params[:merchandise_id] || Merchandise.first
    @country = Country.find_by_id params[:country_id] || Country.first
    @data = MarketPost.find :all, conditions: [ "country_id = ? and merchandise_id = ?", @country.id, @merc.id], order: "created_at desc, price asc"
    respond_with @data
  end
end

