Rails.application.routes.draw do
  devise_for :users
  root to: "races#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :races, only: [:create, :index, :show] do
    resources :targets, only: [:new, :create]
  end
  resources :buddies, only: [:show] do
    resources :targets, only: [:update,]
  end

  resources :targets, only: [:edit, :update, :destroy]

  resources :invites, only: [:index, :update, :destroy, :create] do #POST  /invites
    resources :reviews, only: [:create]
  end

  resources :chats, only: [:show, :index, :destroy] do
    resources :messages, only: [:create, :destroy, :update]
  end

  resources :invites do
    member do
      patch :accept #PATCH /invites/:id/accept
    end
  end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/profile", to: "profiles#show"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
