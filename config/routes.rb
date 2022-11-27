Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  resources :autos
  resources :mapas
  resources :usuarios
  resources :alquilers
  resources :informes

  root "mapas#show"
  get '/iniciar_sesion', to: 'mains#show', as: 'iniciar_sesion' #referencia a iniciar sesion
  get '/validar_informe', to: 'informes#validar', as: 'validar_informe' # referencia a accion validar informes admin
  get '/cerrar_sesion', to: 'logouts#destroy', as: 'cerrar_sesion' # referencia a cerrar secion
  post '/mains/validar', to: 'mains#validar'
  post '/alquilers/devolver', to: 'alquilers#check_auto'
  post '/alquilers/extender', to: 'alquilers#extender'


end
