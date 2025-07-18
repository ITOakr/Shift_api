Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tests, only: %i[index]

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
      namespace :auth do
        resources :sessions, only: %i[index]
      end
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
