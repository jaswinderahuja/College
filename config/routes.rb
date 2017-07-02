Rails.application.routes.draw do

  post 'campus_drives/create'

  get 'campus_drives/index'
  get 'campus_drives/get_departments'
  get 'dashboard/get_companies'

  get  'college_registeration/index'
  get  'college_registeration/index_back'
  post 'college_registeration/create'

  get '/', to: 'landing#index'
  get '/dashboard', to: 'dashboard#index'
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations' }
  match 'user_root' => 'dashboard#index', as: :user_root,via: :all

  get 'locations/countries'
  get 'locations/states'
  get 'locations/cities'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
