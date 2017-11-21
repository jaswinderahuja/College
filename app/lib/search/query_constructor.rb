module Search
	class QueryConstructor
		def initialize
			@openings_search_fields = ["department","opening_type","position","location.name"]
			@companies_search_fields = ["business_nature","description","headquarter.name","name"]			
		end

		def openings_by_keywords(keyword,sort_by=nil,openings_search_fields=nil,companies_search_fields=nil)
			@openings_search_fields = openings_search_fields if openings_search_fields.present?
			@companies_search_fields = companies_search_fields if companies_search_fields.present?						
			body= {
			  :query=> {
			       :bool=> {
			        :should=> [
			            { 
			                :multi_match=> {
			                  :query=> keyword,
			                  :fields=> @openings_search_fields
			                }
			            }, 
			            {
			                :has_parent=> {
			                    :parent_type=> "companies",
			                    :query=> {
			                        :multi_match=> {
			                        :query=> keyword,
			                        :fields=> @companies_search_fields
			                      }
			                    }
			                }
			            }
			        ]
			    } 
			  }
			}
			if sort_by.present?
				body[:sort] = [
			    		{
			      			:"#{sort_by}"=> {
			        		:order=> "desc"
			    	  		}
			    		}
			  		]
			end
			return body
		end

		def filter_by_ids(ids)
			body = {
				:query=> {
				    :constant_score=> {
				      :filter=>{
				        :terms=> {
				          :_id=> ids
				        }
				      }
				    }
				}
			}
			return body
		end
	end
end