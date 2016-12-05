class DashboardController < AuthenticatedController
  layout 'landing'
  def index
    redirect_to(:controller=>"colleges",:action=>"index") 
  end
end
