Erep::Application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'

  devise_for :admins

  post "/receive" => "home#receive"
  get "/filter/:merchandise_id/:country_id" => "market_posts#filter"

  resources :merchandises
  root to: "market_posts#filter"
end

