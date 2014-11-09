Rails.application.routes.draw do

  get 'tweets/index'

  get 'tweets/show'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  match 'users/auth/:provider/callback', to: 'welcome#index', via: 'get' # should return to confirm email screen

  root to: 'welcome#index'

end
