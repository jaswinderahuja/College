class ConnectionsDashboardController < ApplicationController
  layout 'dashboard'
	
  def index
  end
  def invitations_sent
  	puts "user===#{current_user}"
    accepted = params[:status] == "accepted" ?  true : (params[:status]=="rejected" ? false : nil)
  	invitations = Invitation.where(:user_id=>current_user.id,:accepted=>accepted)
  	openings = []
    invitation_status = {}
  	invitation_updated = {}
  	invitations.each do |invitation|
  		invitation_status["#{invitation.opening_id}"] = invitation.accepted
      invitation_updated["#{invitation.opening_id}"] = invitation.updated_at.strftime("%d-%m-%Y")
  	end
  	openings = invitation_status.keys
  	si = Search::SearchInvitations.new(openings, invitation_status, invitation_updated)
  	data = si.search
  	render :json=>{:data=>data}
  end
end
