Rails.application.routes.draw do
  namespace :api do
    resources :stations
    resources :measurements
  end
end
