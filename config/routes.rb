Rails.application.routes.draw do
  get "test/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"

  # Routes for API
  namespace :api do
    namespace :v1 do
      resources :provinces, only: [:index, :show] do
        get :districts, on: :member
      end
      resources :districts, only: [] do
        get :neighborhoods, on: :member
      end
      resources :postal_codes, only: [:index, :show] do
        collection do
          get :search
        end
      end
    end
  end

  #Routes for website
  scope "(:locale)", locale: /en|tr/ do
    # Provinces
    resources :provinces, only: [:index] do
      member do
        get :districts  # /provinces/1/districts
      end
      collection do
        get :search     # /provinces/search
      end
    end
  
    # Districts
    resources :districts, only: [] do
      member do
        get :neighborhoods  # /districts/1/neighborhoods
      end
    end
  
    # Postal Codes
    resources :postal_codes, only: [:index, :show] do
      collection do
        get :by_location  # /postal_codes/by_location?province_id=1&district_id=2
      end
    end
  end
  
end

