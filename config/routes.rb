Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers
  resources :informes

  root "mapas#show"
  
  post '/alquilers/devolver', to: 'alquilers#check_auto'
  post '/alquilers/extender', to: 'alquilers#extender'
end
