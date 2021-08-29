Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # API-specific routes to respect controllers>api>v1 architecture
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [ :index, :show, :update, :create, :destroy ] do
        resources :comments, only: [ :create]
      end
      resources :comments, only: [ :destroy]
    end
  end

end
