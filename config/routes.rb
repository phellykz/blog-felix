Rails.application.routes.draw do
  get 'user/index'

  devise_for :users
  
  resources :posts do
  	resources :comments
  end
  
  get 'home/index'


  root "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
