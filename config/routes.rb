Erep::Application.routes.draw do
  mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'

  devise_for :admins

  root to: "home#index"
  post "/receive" => "home#receive"
end

