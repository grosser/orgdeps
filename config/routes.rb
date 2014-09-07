Rails.application.routes.draw do
  root "organizations#index"
  resources :organizations do
    resources :repositories, only: [:index, :show]
  end

  # auth
  match "auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "signout" => "sessions#destroy", as: :signout
end
