class Api::V0::ConnectionsDashboardController < ApplicationController
    layout 'dashboard'
  

  # Author : Jaswinder Singh
  # <b>Endpoints</b> all
  # <b>Request Type</b> PUT
  # 
  # <b>Request Format</b>
  #   {
  #     "opening_id": "1"
  #   }
  # <b>Route </b> /api/v0/college-seen-status
  # <b>Authentication Required</b>
  # <b>Response Format</b>
  #    Response on Success (status 200) -
  #    { 
  #     "message" => "Invitation status update."
  #    }
  
  def college_seen_status
    @campus_id = current_user.campus_users.first.campus_id
    op_id = params["op_id"]
    invi_status=CRUD::Utility::Invitations.new(@campus_id)
    response, status = invi_status.update_is_college_user_seen(op_id)
    render :json=>{:data=>response}
  end

end
