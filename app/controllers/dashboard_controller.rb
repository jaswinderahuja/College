class DashboardController < AuthenticatedController
  layout 'dashboard'
  before_filter :college_registration_exists?
  

  def college_registration_exists?
    puts "=========cool==================="
  	if current_user.university_users.present? or current_user.college_users.present?
  	else
  	    redirect_to(:controller=>"college_registeration",:action=>"index") 	
  	end
  end

  def index
  end
end
