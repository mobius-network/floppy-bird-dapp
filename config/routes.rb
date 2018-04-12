Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'app#index'

  get '/auth', to: 'auth#challenge'
  post '/auth', to: 'auth#authenticate'

  get '/balance', to: 'app#balance'
  post '/pay', to: 'app#pay'
end
