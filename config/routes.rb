Bozo::Application.routes.draw do
  devise_for :users

  resources :users
  resources :articles
  resources :categories

  root :to => "dashboard#index"

  get "dashboard/index"
  match 'dashboard/byuser' => 'dashboard#byuser'

end
