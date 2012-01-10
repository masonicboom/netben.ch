BandwidthBuzz::Application.routes.draw do
  root :to => 'pages#home'

  resources :tests, :only => [:create]
  resources :cafes, :only => [:show]
end
