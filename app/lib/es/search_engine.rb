require "#{Rails.root}/app/lib/es/configuration.rb"

module ES
	class SearchEngine < Configuration 
		INDEX_NAME = "company"
    	INDEX_TYPES = [COMPANIES = "companies", OPENINGS = "openings"]

		def initialize
			@client = get_client
		end

		# def search_by_location(city)
		# 	query = {
		# 	    "query_string": {
		# 	      "fields": ["city"], 
		# 	      "query": "#{city}"
		# 	    }
		# 	}
		# 	@client.search :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:body{:query=>query}
		# end

		def get_company_from_hash(hash,company_id)
			company_hash = {}
			hash["hits"]["hits"].each do |row|
				company_hash = row["_source"]  if row["_id"].to_s == company_id.to_s 
			end
			return company_hash
		end

		def initial_load(from,size)
			company_ids = []
			result = []
			openings_hash = @client.search :index=>INDEX_NAME,:type=>OPENINGS,
			:body=>{
				:from=>from,
				:size=>size ,
				:query=>{
					:match_all=>{}
				},
				:sort=>[
					    {
					      :package_upper=> {
					        :order=> "desc"
					      }
					    },
					    {
					      :no_of_openings=> {
					        :order=>"desc"
					      }
					    }
				]
			}
			
			openings_hash["hits"]["hits"].each do |row|
				company_ids << row["_parent"].to_i
			end
			company_ids.uniq!

			companies_hash = @client.search :index =>INDEX_NAME,:type=>COMPANIES,
			:body=>{
				:query=> {
				    :constant_score=> {
				      :filter=>{
				        :terms=> {
				          :_id=> company_ids
				        }
				      }
				    }
				}
			}

			openings_hash["hits"]["hits"].each do |row|
				result << {:opening_id=>row["_id"].to_s,:company=>get_company_from_hash(companies_hash,row["_parent"]),:opening=>row["_source"] }
			end	
			return result
		end

	end
end