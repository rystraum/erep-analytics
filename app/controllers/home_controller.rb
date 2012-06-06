class HomeController < ApplicationController
  def index
  end

  def receive
    redirect_to root_path
  end
end

