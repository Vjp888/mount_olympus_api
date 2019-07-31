Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :olympians, only: [:index]
      resources :events, only: [:index] do
        get '/medalists', to: 'events/medalists#show'
      end
      get '/olympian_stats', to: 'statistics#show'
    end
  end

end
