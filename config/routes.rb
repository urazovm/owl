Owl::Application.routes.draw do
  devise_for :users

  resources :lists, path: '' do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: :show
end
