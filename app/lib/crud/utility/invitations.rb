module CRUD
  module Utility
    class Invitations < Notifications

      def get_request_sent
        invitations = Invitation.where(:campus_id=>@campus_id,:is_college_user_seen=>false)
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
          construct_response(data)
        end

      end

      def update_is_college_user_seen(op_id)
        return "opening id is missing!.", 400 unless op_id.present?
        Invitation.where(:opening_id=>op_id,:campus_id=>@campus_id).limit(1).update_all(:is_college_user_seen=>true)
        return "Invitation seen status updated successfully!.", 200
      end

      def construct_response(data)
        response = []
        data.each do |row|
          response << {:message=>row[:company]["name"] + " has "+row[:invitation_status]+" your invitation for the opening of #{row[:opening]["position"]} role",:url=>"/dashboard/company_details?op_id=#{row[:opening_id]}&accepted=true" }
        end
        return response
      end
    end
  end
end