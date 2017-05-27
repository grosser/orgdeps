Rails.application.routes.draw do
  root "organizations#index"
  resources :organizations, only: [:index, :edit, :update] do
    resources :repositories, only: [:index, :show]
  end

  # auth
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/logout" => "sessions#destroy", as: :logout
end
