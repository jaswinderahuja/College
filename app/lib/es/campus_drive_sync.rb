require 'es/elasticsearch_configuration.rb'

module ES
	class CampusDriveSync < ElasticsearchConfiguration
		INDEX_NAME = "college"
		INDEX_TYPES = [CAMPUS_DETAILS = "campus_details",CAMPUS_DRIVES ="campus_drives"]
		
		def initialize
			@client = get_client			
		end

		def campus_id_by_drive_id(drive_id)
			CampusInvite.find(drive_id).campus_id
		end

		def create_campus_hash(univ_id)
		    hash = {}
			row = ActiveRecord::Base.connection.select_rows("select c.college_name,c.university_name,cities.name,c.created_at from campus c
					inner join campus_addresses addr on addr.campus_id =  c.id
					inner join pincodes pin on pin.pincode = addr.pin_code
					inner join cities on cities.id = pin.city_id where c.id=#{univ_id};").first
			hash = {:college_name=>row[0],:university_name=>row[1],:city=>row[2],:timestamp=>row[3],:approved_by=>"UGC",:rank=>"111",:description=>" something",:established=>"year",:asia_rank=>"xx"}
			return hash
		end

		def create_campus_drive_hash(drive_id)
		    hash = {}
			row = res = ActiveRecord::Base.connection.select_rows("select c.college_name,c.university_name,drive.address,drive.date_of_drive,drive.no_of_students,d.name,drive.hod_email ,drive. coordinator_email_1,drive.coordinator_email_2,drive.coordinator_phone_1,drive.coordinator_phone_2,drive.description,drive.status from campus_invites drive inner join campus c on c.id=drive.campus_id inner join departments d on d.id = drive.department_id where drive.id=#{drive_id}").first
			hash = {:address=>row[2],:date_of_drive=>row[3],:no_of_students=>row[4],:department=>row[5],:hod_email=>row[6],:coordinator_email_1=>row[7],:coordinator_email_2=>row[8],:coordinator_phone_1=>row[9],:coordinator_phone_2=>row[10],:description=>row[11],:status=>row[12]}
			return hash
		end

		def self.execute(drive_id)
			begin
				CampusDriveSync.new.create_campus_drive_index(drive_id)
			rescue Exception => e
				user_id = CampusInvite.find(drive_id).campus.campus_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
		end

		def create_campus_drive_index(drive_id)
			data = {}
			clg_id = campus_id_by_drive_id(drive_id)
			data = create_campus_hash(clg_id)
			data [:drive] = create_campus_drive_hash(drive_id)			
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:id=>drive_id,:body=>data
		end

	end
end