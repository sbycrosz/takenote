Takenote::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/sign_up', to: 'users#create'
      post '/sign_in', to: 'sessions#create'
      delete '/sign_out', to: 'sessions#destroy'

      get '/notes', to: 'notes#index'
      post '/notes', to: 'notes#create'
      put '/notes/:id', to: 'notes#update'
      delete '/notes/:id', to: 'notes#destroy'

      get 'me', to: 'users#me'
      put 'me', to: 'users#update'
    end
  end
  root :to => 'static#index'
end
