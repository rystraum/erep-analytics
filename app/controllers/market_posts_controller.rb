class MarketPostsController < ApplicationController
  respond_to :html, :json
  before_filter :get_merc_and_country
  def index
    @data = MarketPost.find :all, conditions: [ "country_id = ? and merchandise_id = ?", @country.id, @merc.id], order: "created_at desc, price asc"
    respond_with @data
  end

  def candlestick
    @data = Candlestick.find :all, conditions: [ "country_id = ? and merchandise_id = ?", @country.id, @merc.id], order: "date desc"
  end

private
  def get_merc_and_country
    @merc = Merchandise.find_by_id params[:merchandise_id] || Merchandise.first
    @country = Country.find_by_id params[:country_id] || Country.first
  end
end

