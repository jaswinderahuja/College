require 'es/elasticsearch_configuration.rb'

module ES
	class ElasticsearchSync < ElasticsearchConfiguration
		INDEX_NAME = "college"
		INDEX_TYPES = [CAMPUS_DETAILS = "campus_details",CAMPUS_DRIVES ="campus_drives"]
		
		def initialize
			@client = get_client			
		end

		def create_hash(univ_id)
		    hash = {}
			row = ActiveRecord::Base.connection.select_rows("select clg.name 'college name',cities.name
				'city',u.name 'university name',u.created_at 'timestamp' from
				college_details clg inner join universities u on u.id=clg.is_affliated_to_id inner join
				college_addresses addr on addr.college_detail_id = clg.id inner join pincodes pin on
				pin.pincode = addr.pin_code inner join cities on cities.id = pin.city_id where clg.id=#{univ_id};").first
			hash = {:college=>row[0],:city=>row[1],:university=>row[2],:timestamp=>row[3],:approved_by=>"UGC",:rank=>"111",:description=>" something",:established=>"year",:asia_rank=>"xx"}
			return hash
		end

		def self.execute(univ_id)
			begin
				ElasticsearchSync.new.create_index(univ_id)
			rescue Exception => e
				user_id = CollegeDetail.find(univ_id).college_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
		end

		def create_index(univ_id)
			data = create_hash(univ_id)
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DETAILS,:body=>data
			
		end

	end
end