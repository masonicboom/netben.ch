BandwidthBuzz::Application.routes.draw do
  root :to => 'pages#mobile'

  resources :tests, :only => [:create]
  resources :cafes, :only => [:show]
end
