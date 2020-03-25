Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'orders#index'
  post '/submit', to: 'orders#submit'

  post '/update', to: 'users#update'
  resource :user_info, only: [:show, :update]
end
