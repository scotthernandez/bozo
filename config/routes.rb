Bozo::Application.routes.draw do
  devise_for :users

  root :to => "dashboard#index"
  
  resources :users
  resources :articles
  resources :categories
  resources :stats

  resource :dashboard, :controller => 'dashboard' do
    collection do
      get :byuser
    end
  end         

end # of routes
