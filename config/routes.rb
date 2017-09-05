Rails.application.routes.draw do
  namespace :api do
    get 'stations', to: 'stations#index'
    get 'station(/:id)/weather', to: 'stations#weather', as: :station_weather

    get 'measurements', to: 'measurements#index'
  end
end
