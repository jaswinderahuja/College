Rails.application.routes.draw do

  namespace :users do    
    get '/profile', to: 'profile_management#index'
    post "edit_social_connect", to: "profile_management#edit_social_connect"
    post "edit", to: "profile_management#edit"
  end

  get 'profile', to: 'profile_management#index'
  
  post 'profile_management/edit', to: 'profile_management#edit'
  post 'profile_management/edit_campus_and_address', to: 'profile_management#edit_campus_and_address'
  post 'profile_management/edit_campus_contact', to: 'profile_management#edit_campus_contact'

  get 'user_help', to: 'user_help#index'
  post 'user_help/create' 
  get 'connections', to: 'connections_dashboard#index' 
  get 'connections_dashboard/invitations_sent'

  post 'campus_drives/create'

  get 'dashboard/company_info'
  get 'dashboard/company_details'
  get 'campus_drives/index'
  get 'campus_drives/get_departments'
  get 'dashboard/get_companies'
  get 'dashboard/search_openings'

  get  'college_registeration/index'
  get  'college_registeration/index_back'
  post 'college_registeration/create'
  post 'dashboard/create_interest'

  get '/', to: 'landing#index'
  get '/dashboard', to: 'dashboard#index'
  devise_for :users, controllers: { sessions: 'users/sessions',registrations: 'users/registrations' }
  match 'user_root' => 'dashboard#index', as: :user_root,via: :all

  get 'locations/countries'
  get 'locations/states'
  get 'locations/cities'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
