Takenote::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/sign_up', to: 'users#create'
      post '/sign_in', to: 'sessions#create'

      get 'me', to: 'users#me'
    end
  end
end
