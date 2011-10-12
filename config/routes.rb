BandwidthBuzz::Application.routes.draw do
  root :to => 'pages#home'
  
  resources :tests, :only => [:create]
end
