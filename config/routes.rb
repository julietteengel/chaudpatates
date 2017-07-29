Rails.application.routes.draw do

  # Added by Koudoku.
  mount Koudoku::Engine, at: 'koudoku'
  scope module: 'koudoku' do
    get 'pricing' => 'subscriptions#index', as: 'pricing'
  end


	require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  ActiveAdmin.routes(self)
	mount Attachinary::Engine => "/attachinary"

  root to: 'pages#home'
  get "/pages/:page" => "pages#show"

  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => "registrations" }
  resources :users, only: [:show]

  resources :cities, only: [:show] do
    get "/:slug" => "cities#show", on: :collection
  end

  resources :trainings, only: [:index, :new, :create, :update, :destroy]
  resources :bookings, only: [:index, :create, :destroy]
  resources :orders, only: [:index]
  resources :orders, only: [:create] do
    resources :payments, only: [:create]
  end

  # post '/stripe/webhooks', to: "stripe#webhooks"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
