module Search
	class SearchInvitations < SearchBase
		
		def initialize(opening_ids,invitation_status,invitation_time)			
			@opening_ids = opening_ids
			@invitation_status = invitation_status
			@invitation_updated_at = invitation_time
			@query_constructor = QueryConstructor.new
			@query_executor = QueryExecutor.new
		end

		def search
			body = @query_constructor.filter_by_ids(@opening_ids)
			puts "#{body.inspect}"
			openings = @query_executor.execute_opening(body)
			response = construct_response(openings)
			return response
		end

		def construct_response(openings_hash)
			company_ids = []
			result = []
			openings_hash["hits"]["hits"].each do |row|
				company_ids << row["_parent"].to_i
			end
			company_ids.uniq!			
			body = @query_constructor.filter_by_ids(company_ids)
			companies_hash = @query_executor.execute_companies(body)
			openings_hash["hits"]["hits"].each do |row|				
				status = invitation(@invitation_status[row["_id"].to_s])				
				result << {:type=>"invitation_sent",:last_updated=>@invitation_updated_at[row["_id"].to_s],:invitation_status=>status,:opening_id=>row["_id"].to_s,:company=>get_company_from_hash(companies_hash,row["_parent"]),:opening=>row["_source"]}
			end	
			return result
		end	

		def invitation(arg)

			case arg
				when nil
					return "Pending"
				when false
					return "Rejected"
				when true				
					return "Accepted"
			end
		end

	end
end