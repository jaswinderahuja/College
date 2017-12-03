module Search
	class QueryConstructor
		SIZE = 5
		@openings_search_fields = ["department","opening_type","position","location.name"]
		@companies_search_fields = ["business_nature","description","headquarter.name","name"]
		def initialize(keyword,openings_search_fields=nil,companies_search_fields=nil,from=0)
			@body = {from: from, size: SIZE,bool: {should: []}}
			@companies_search_fields = companies_search_fields if companies_search_fields.present?
			@openings_search_fields = openings_search_fields if openings_search_fields.present?
			@keyword = keyword if keyword.present?
			add_minimum_should if keyword.present?
		end

		def create
			if @keyword.present?
				searach_by_openings
				searach_by_parent_company
			end
			sort_by if @sort_by.present?
			location_filter if @location_filter.present?
			position_filter if @position_filter.present?
		end

		# def openings_by_keywords(keyword,sort_by=nil,openings_search_fields=nil,companies_search_fields=nil,from=0)
		# 	@openings_search_fields = openings_search_fields if openings_search_fields.present?
		# 	@companies_search_fields = companies_search_fields if companies_search_fields.present?
		# 	@body[:query] =  {
		# 	       :bool=> {
		# 	        :should=> [
		# 	            {
		# 	                :multi_match=> {
		# 	                  :query=> keyword,
		# 	                  :fields=> @openings_search_fields
		# 	                }
		# 	            },
		# 	            {
		# 	                :has_parent=> {
		# 	                    :parent_type=> "companies",
		# 	                    :query=> {
		# 	                        :multi_match=> {
		# 	                        :query=> keyword,
		# 	                        :fields=> @companies_search_fields
		# 	                      }
		# 	                    }
		# 	                }
		# 	            }
		# 	        ]
		# 	    }
		# 	  }
		# 	if sort_by.present?
		# 		@body[:sort] = [
		# 	    		{
		# 	      			:"#{sort_by}"=> {
		# 	        		:order=> "desc"
		# 	    	  		}
		# 	    		}
		# 	  		]
		# 	end
		# 	return @body
		# end

		def searach_by_openings
			@body[:query][:bool][:should].push({:multi_match=> {
													                  :query=> @keyword,
													                  :fields=> @openings_search_fields
													                }
													            })
		end

		def searach_by_parent_company
			@body[:query][:bool][:should].push({:has_parent=> {
												                    :parent_type=> "companies",
												                    :query=> {
												                        :multi_match=> {
												                        :query=> @keyword,
												                        :fields=> @companies_search_fields
												                      }
												                    }
												                	}
												                })
			end

		def add_minimum_should
			@body[:query][:bool][:minimum_should_match] = 1
		end

		def location_filter(body,filters)
			body[:query][:bool][:filter] = { :bool=> { :must=> [] } } if !@body[:query][:bool][:filter].present?
			@body[:query][:bool][:filter][:bool][:must] << { :terms=> { :"location.name"=> filters } }
			body[:query][:bool][:minimum_should_match] = 1 if @body[:query][:bool][:should].present?  # if it is queried and filter then add this condition
			return @body
		end

		def position_filter(body,filters)
			@body[:query][:bool][:filter] = { :bool=> { :must=> [] } } if !@body[:query][:bool][:filter].present?
			@body[:query][:bool][:filter][:bool][:must] << { :terms=> {:position=> filters }}
			@body[:query][:bool][:minimum_should_match] = 1 if @body[:query][:bool][:should].present?  # if it is queried and filter then add this condition
			return @body
		end


		def sort_by
				@body[:sort] = [ {
		      		:"#{sort_by}"=> {
		        		:order=> "desc"
		      		}
		    	}
		    ]
		end

		def filter_by_ids(ids)
			@body = {
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
			return @body
		end
	end
end
