EvrasiaStocks::Application.routes.draw do
  resources :stocks, :only => [:index, :show, :create]
  resources :restaurants, :only => [:index, :show, :create]

  get 'about' => 'about#index'
  root :to => 'stocks#index'
end
