EvrasiaStocks::Application.routes.draw do
  get "restaurant/index"
  get "restaurant/show"
  root :to => 'stocks#index'

  resources :stocks

  resources :restaurants
end
