Owl::Application.routes.draw do
  devise_for :users

  resources :lists, path: '' do
    resources :comments, only: [:create, :destroy]
    resource :love, only: [:create, :destroy]
    resources :loves, only: [:index]
  end
  resources :users, only: :show do
    resources :loves, only: [:index]
  end
end
