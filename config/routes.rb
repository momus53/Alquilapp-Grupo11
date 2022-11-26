Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers
  resources :informes
  
  get '/validar_informe' => 'informes#validar', as: 'validar_informe'
  #get "/informes/validar" => "informes#validar"


  root "mapas#show"

end
