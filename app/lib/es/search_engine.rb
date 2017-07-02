require 'es/elasticsearch_configuration.rb'

module ES
	class SearchEngine < ElasticsearchConfiguration 
		def initialize
			@client = get_client
		end

		def search_by_location(city)
			query = {
			    "query_string": {
			      "fields": ["city"], 
			      "query": "#{city}"
			    }
			}
			@client.search :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:body{:query=>query}
		end

		


	end
end