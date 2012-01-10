BandwidthBuzz::Application.routes.draw do
  root :to => 'pages#home'

  resources :benches, :only => [:create]
  resources :places, :only => [:show]
end
