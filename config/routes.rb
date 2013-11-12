Owl::Application.routes.draw do
  devise_for :users

  resources :lists, path: ''
end
