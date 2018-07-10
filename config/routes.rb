# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :stations, only: %i[index show]
    get 'station(/:id)/weather', to: 'stations#weather', as: :station_weather
    get 'station(/:id)/history', to: 'stations#history', as: :station_history

    get 'measurements', to: 'measurements#index'

    get :weather, to: 'weather#at_location'
  end
end
