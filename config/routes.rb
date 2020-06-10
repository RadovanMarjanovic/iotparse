Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    namespace :api, constraints: { format: 'json' } do
      namespace :v1 do
        resources :users, only: [ :create, :update ]
        # resources :users, only: [ :create, :update ], param: :_username
        post '/auth/login', to: 'authentication#login'
        get '/*a', to: 'application#not_found'
      end
    end
end
