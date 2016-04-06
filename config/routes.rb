Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'comments', to: 'comments#index'
      get 'comments/count', to: 'comments#count'
      get 'pull_requests', to: 'pull_requests#index'
      get 'pull_requests/count', to: 'pull_requests#count'
      get 'issues', to: 'issues#index'
      get 'issues/count', to: 'issues#count'
    end
  end

  get '/', to: 'slack_integration#index'
  post '/', to: 'slack_integration#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  post '/events', to: 'events#create'
  get '/events', to: 'events#index'
end
