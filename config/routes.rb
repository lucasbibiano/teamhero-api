Rails.application.routes.draw do
  get '/', to: 'slack_integration#index'
  post '/', to: 'slack_integration#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  post '/events', to: 'events#create'
  get '/events', to: 'events#index'
end
