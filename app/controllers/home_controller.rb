class HomeController < ApplicationController
  def index
  end

  def receive
    Item.create! params[:item]
    redirect_to root_path
  end
end

