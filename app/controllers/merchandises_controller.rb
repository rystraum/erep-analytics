class MerchandisesController < ApplicationController
  before_filter :get_merchandise
  def show
    @posts = @merchandise.market_posts
  end

protected
  def get_merchandise
    @merchandise = Merchandise.find_by_id params[:id]
  end
end

