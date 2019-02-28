Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  root 'articles#index'
  get '/', to: 'articles#index'
  get '/new', to: 'articles#new'
end
