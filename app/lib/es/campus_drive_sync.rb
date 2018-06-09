require "#{Rails.root}/app/lib/es/configuration.rb"

module ES
	class CampusDriveSync < Configuration
		INDEX_NAME = "college"
		INDEX_TYPES = [CAMPUS_DETAILS = "campus_details",CAMPUS_DRIVES ="campus_drives"]
		
		def initialize
			@client = get_client			
		end

		def campus_id_by_drive_id(drive_id)
			CampusInvite.find(drive_id).campus_id
		end

		def create_campus_drive_hash(drive_id)
			hash_response = {}
			hash_data =  CampusInvite.joins(:campus,:department,:city).where("campus_invites.id=#{drive_id}")
			.select("college_name,university_name,address,date_of_drive,no_of_students,departments.name as department_name,hod_email,coordinator_email_1,coordinator_email_2,coordinator_phone_1,coordinator_phone_2,description,status,cities.name as location").last.as_json
			date_of_drive = (Date.parse(hash_data["date_of_drive"].to_s).to_time.to_i rescue nil)
			hash_response = {
				:address=>hash_data["address"],
				:date_of_drive=>date_of_drive,
				:no_of_students=>hash_data["no_of_students"].to_i,
				:department=>hash_data["department_name"],
				:description=>hash_data["description"],
				:contact_details=>{
					:hod_email=>hash_data["hod_email"],
					:email_1=>hash_data["coordinator_email_1"],
					:email_2=>hash_data["coordinator_phone_2"],
					:phone_1=>hash_data["coordinator_phone_1"],
					:phone_2=>hash_data["coordinator_phone_2"],
				},
				location: {
					name: hash_data["location"]
					}
			}
			return hash_response
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
			data = create_campus_drive_hash(drive_id)
			campus_id = campus_id_by_drive_id(drive_id)
			@client.index :index=>INDEX_NAME,:type=>CAMPUS_DRIVES,:id=>drive_id,:parent=>campus_id,:body=>data
		end

		#  bulk api to sync all the active campus drives pending


		def self.complete_index
			begin
				campus_drive_sync = CampusDriveSync.new
				drives = CampusInvite.where(:status=>true).collect(&:id)
				master_hash = []
				drives.each do |drive|
					index_hash = {"index":{"_index": INDEX_NAME, "_type": CAMPUS_DRIVES, "_id": drive.id }}
					data_hash = create_campus_drive_hash(drive.id)
					master_hash << index_hash 
					master_hash << data_hash
				end				
				bulk(master_hash)
			rescue Exception => e
				user_id = 1 # CampusInvite.find(drive_id).campus.campus_users.first.user_id
				AppException.create!(:message=>e.message,:stacktrace=>e.backtrace,:created_by=>user_id)
			end
				
		end

		def self.bulk(data =[])
			@client.bulk :body=>data
		end

	end
end
