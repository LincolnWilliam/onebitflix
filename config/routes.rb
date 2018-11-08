Rails.application.routes.draw do
  devise_for :users
  root :to => "home#index"
  #verificar documentação rails routes.
  #namespace- toda url que esta sendo faladdo dentro ,é esperado que ela começe com api. /v1
  namespace :api do
    namespace :v1 do
      #metodo http get pegar informações do dashboards. // relaciona
      det '/dashboard', to: 'dashboards#index', as: 'dashboard'
      # resources maneira de gerar varias rotas, 
      # favorites relacionando - renomeando para my_list ,
      resources :favorites, path: "my_list", only: %i( index create )
      # deletar um favorito,  como é polimorphica pode deletar um favorito tipo=type serie ou movie
      delete '/my_list/:type/:id', to: 'favorites#destroy'
      resources :reviews, only: [:index, :create]
      resources :searches, path: "search", only: :index
      resources :series, only: :show
      resources :movies, only: :show do
        member do
          get '/executions', to: 'executions#show'
          put '/executions', to: 'executions#update'
        end 
      end  
      resources :recommendations, only: :index
    end
  end
end       