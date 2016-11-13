Rails.application.routes.draw do
  get '/', to: 'landing#index'
  get '/dashboard', to: 'dashboard#index'
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations' }
  match 'user_root' => 'dashboard#index', as: :user_root,via: :all
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
