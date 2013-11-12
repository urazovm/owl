Owl::Application.routes.draw do

  resources :lists, only: [:index], path: ''

end
