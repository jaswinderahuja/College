module List
	class City < Search::SearchBase

		def initialize			
			@query_constructor = QueryConstructor.new
			@query_executor = QueryExecutor.new
		end

		def search
			body = @query_constructor.top_city_list
			puts "#{body.inspect}"
			openings = @query_executor.execute_opening(body)
			response = construct_response(openings)
			return response
		end

		def construct_response(data)
			locations = []
			data["hits"]["hits"].each do |item|
				locations << {:name=> item["_source"]["location"]["name"]}
			end			
			locations.uniq! {|e| e[:name]}
			return locations
		end
	end
end