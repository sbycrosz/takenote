Takenote::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/sign_up', to: 'users#create'
      post '/sign_in', to: 'sessions#create'
    end
  end
end