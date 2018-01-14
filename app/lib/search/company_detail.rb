module Search
	class CompanyDetail < SearchBase
		
		def initialize(opening_id)		
			@opening_ids = [opening_id]
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
		
	end
end