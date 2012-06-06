class HomeController < ApplicationController
  def index
  end

  def receive
    Item.create! params[:item]

    if request.xhr?
      render text: "ok"
    else
      redirect_to root_path
    end
  end
end

