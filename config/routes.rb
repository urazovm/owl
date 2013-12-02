Owl::Application.routes.draw do
  devise_for :users

  root to: 'lists#index', as: 'lists'

  resources :lists, only: [:show, :edit, :update, :destroy, :new, :create] do
    resource :love, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
    resources :items, only: [] do
        resource :image, only: :destroy
    end
  end

  resources :users, path: '', only: [:show, :edit, :update] do
    resource :love, only: [:create, :destroy]
    resource :follow, only: [:create, :destroy]
    resources :loves, only: [:index]
    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
end
