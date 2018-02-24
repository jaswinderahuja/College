module CRUD
  module Utility
    class Invitations < Notifications

      def get_request_sent
        invitations = Invitation.where(:campus_id=>@campus_id)
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