class ConnectionsDashboardController < ApplicationController
  layout 'dashboard'
	
  def index
  end
  def invitations_sent
  	puts "user===#{current_user}"
    response = {:data=>{}}
    accepted = params[:status] == "accepted" ?  true : (params[:status]=="rejected" ? false : nil)
  	invitations = Invitation.where(:user_id=>current_user.id,:accepted=>accepted)
  	if invitations.present?
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
      response[:data] = data
     end 
  	render :json=>response
  end

  #  this api will provide information of accepted/rejected request sent from college side
  def notifications
    @campus_id = current_user.campus_users.first.campus_id
    invi_status=CRUD::Utility::Invitations.new(@campus_id)
     data = invi_status.get_request_sent
     render :json=>{:data=>data}
  end

end
