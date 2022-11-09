Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers

  root "mapas#show"
#  root "informe#new"
#  root "informe#show"
#  root "informe#index"
end
