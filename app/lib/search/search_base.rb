module Search
	class SearchBase
		def initialize(query_string,sort_by=nil,city_filter=[],position=[],openings_search_fields=nil,companies_search_fields=nil)			
			# raise "Query string can't be blank!!" if query_string.blank?
			@keyword = query_string
			@sort_by = sort_by
			@city_filter = city_filter
			@position = position
			@openings_search_fields = openings_search_fields
			@companies_search_fields = companies_search_fields
			@query_constructor = QueryConstructor.new			
			@query_executor = Search::QueryExecutor.new
		end

		def search
			if @keyword.present?
				body = @query_constructor.openings_by_keywords(@keyword,@sort_by,@openings_search_fields,@companies_search_fields)						
			else				
				body = @query_constructor.match_all(@sort_by)
			end
			body = @query_constructor.location_filter(body,@city_filter) if @city_filter.present?						
			body = @query_constructor.position_filter(body,@position) if @position.present?						
			puts "#{body.inspect}"
			openings = @query_executor.execute_opening(body)
			response = construct_response(openings)
			return response
		end


	private

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
				result << {:opening_id=>row["_id"].to_s,:company=>get_company_from_hash(companies_hash,row["_parent"]),:opening=>row["_source"] }
			end	
			return result
		end	

		def get_company_from_hash(hash,company_id)
			company_hash = {}
			hash["hits"]["hits"].each do |row|
				company_hash = row["_source"]  if row["_id"].to_s == company_id.to_s 
			end
			return company_hash
		end

	end
end