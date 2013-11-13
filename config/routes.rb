Owl::Application.routes.draw do
  devise_for :users

  resources :lists, path: '' do
    resource :love, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update] do
    resource :love, only: [:create, :destroy]
    resource :follow, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
end
