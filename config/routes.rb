Erep::Application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'

  devise_for :admins

  post "/receive" => "home#receive"
  get "/marketposts(/:merchandise_id(/:country_id))" => "market_posts#index"
  get "/candlestick(/:merchandise_id(/:country_id))" => "market_posts#candlestick"
  get "/statistics(/:merchandise_id(/:country_id))" => "market_posts#statistics"

  resources :merchandises
  root to: "market_posts#index"
end

