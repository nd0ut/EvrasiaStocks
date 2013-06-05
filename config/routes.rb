EvrasiaStocks::Application.routes.draw do
  root :to => 'stocks#index'

  resources :stocks
  resources :restaurants

  get 'about' => 'about#index'
end
