Owl::Application.routes.draw do
  devise_for :users

  root to: 'lists#index', as: 'home'

  resources :lists, only: [:show, :edit, :update, :destroy, :new] do
    resource :love, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
    resources :items, only: [:new, :destroy]
  end

  resources :reports, only: :create

  match '/about', to: 'pages#about', via: 'get', as: :about
  match '/legal', to: 'pages#legal', via: 'get', as: :legal
  match '/robots.txt', to: 'pages#robots', via: 'get', as: :robot

  resources :users, path: '', only: [:show, :edit, :update] do
    resource :love, only: [:create, :destroy]
    resource :follow, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
end
