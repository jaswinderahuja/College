class ConnectionsDashboardController < ApplicationController
  layout 'dashboard'
	
  def index
  end
  def invitations_sent
  	puts "user===#{current_user}"
  	invitations = Invitation.where(:user_id=>current_user.id)
  	openings = []
  	invitation_status = {}
  	invitations.each do |invitation|
  		invitation_status["#{invitation.opening_id}"] = invitation.accepted
  	end
  	openings = invitation_status.keys
  	si = Search::SearchInvitations.new(openings,invitation_status)
  	data = si.search
  	render :json=>{:data=>data}
  end
end
