Rails.application.routes.draw do

  

	#routing pages within the application
  root 'static_pages#home'
  
  get '/help', to: 'static_pages#help' #here you have both the  _path and the _url

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new' #this is the path for new users

  post '/signup', to: 'users#create'

  get  '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
