Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers

  root "mapas#show"
 get '/informes', to: 'informes#index'	# muestra todos los informes
 get '/informes/new', to: 'informes#new'	# crea un nuevo informe
end
