Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers
  resources :informes

  root "mapas#show"
  get '/mains/show', to: 'mains#show'
  get '/validar_informe', to: 'informes#validar', as: 'validar_informe' # referencia a accion validar informes admin
  get '/eliminar_informe', to: 'informes#eliminar', as: 'eliminar_informe' #referencia a la accion de eliminar informe como admin

  delete '/mains/logouts', to: 'logouts#destroy'
  post '/alquilers/update', to: 'alquilers#update'
  post '/alquilers/validar', to: 'alquilers#validar'
  post '/mains/validar', to: 'mains#validar'
  post '/alquilers/devolver', to: 'alquilers#check_auto'
  post '/alquilers/extender', to: 'alquilers#extender'
end
