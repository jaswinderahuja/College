require "#{Rails.root}/app/lib/es/configuration.rb"

module ES
	class CampusSync < Configuration
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
			hash = {:college_name=>row[0],:university_name=>row[1],:city=>row[2],:approved_by=>"UGC",:rank=>111,:description=>" something",:established_year=>1990,:asia_rank=>1}
			return hash
		end

		def self.execute(univ_id)
			begin
				CampusSync.new.create_campus_detail_index(univ_id)
			rescue Exception => e
				user_id = Campus.find(univ_id).campus_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
		end

		def create_campus_detail_index(univ_id)
			data = create_campus_hash(univ_id)
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DETAILS,:id=>univ_id,:body=>data
		end

	end
end