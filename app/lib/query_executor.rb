class QueryExecutor < ES::Configuration
		INDEX_NAME = "company"
    	INDEX_TYPES = [COMPANIES = "companies", OPENINGS = "openings"]

		def initialize
			@client = get_client			
		end

		def execute_opening(body=nil)
			@body = body if body.present?
			openings_hash = @client.search :index=>INDEX_NAME,:type=>OPENINGS,:body=>@body			
		end

		def execute_companies(body)
			@body = body if body.present?
			companies_hash = @client.search :index=>INDEX_NAME,:type=>COMPANIES,:body=>@body
		end
end