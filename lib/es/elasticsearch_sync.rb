require 'es/elasticsearch_configuration.rb'

module ES
	class ElasticsearchSync < ElasticsearchConfiguration
		INDEX_NAME = "college"
		INDEX_TYPES = [CAMPUS_DETAILS = "campus_details",CAMPUS_DRIVES ="campus_drives"]
		
		def initialize
			@client = get_client			
		end

		def create_campus_hash(univ_id)
		    hash = {}
			row = ActiveRecord::Base.connection.select_rows("select c.college_name,c.university_name,cities.name,c.created_at from campus c
					inner join campus_addresses addr on addr.campus_id =  c.id
					inner join pincodes pin on pin.pincode = addr.pin_code
					inner join cities on cities.id = pin.city_id where c.id=#{univ_id};").first
			hash = {:college=>row[0],:university=>row[1],:city=>row[2],:timestamp=>row[3],:approved_by=>"UGC",:rank=>"111",:description=>" something",:established=>"year",:asia_rank=>"xx"}
			return hash
		end

		def self.sync_campus(univ_id)
			begin
				ElasticsearchSync.new.create_campus_detail_index(univ_id)
			rescue Exception => e
				user_id = Campus.find(univ_id).campus_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
		end

		def self.sync_campus_drives(drive_id)
			begin
				ElasticsearchSync.new.create_campus_drive_index(drive_id)
			rescue Exception => e
				user_id = Campus.find(univ_id).campus_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
		end

		def create_campus_drive_index(drive_id)
			data  = create_drive_hash(drive_id)
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:body=>data
		end

		def create_campus_detail_index(univ_id)
			data = create_campus_hash(univ_id)
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DETAILS,:body=>data
		end

	end
end