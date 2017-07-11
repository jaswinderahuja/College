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
		    hash = {}
			row = res = ActiveRecord::Base.connection.select_rows("select c.college_name,c.university_name,drive.address,drive.date_of_drive,drive.no_of_students,d.name,drive.hod_email ,drive. coordinator_email_1,drive.coordinator_email_2,drive.coordinator_phone_1,drive.coordinator_phone_2,drive.description,drive.status from campus_invites drive inner join campus c on c.id=drive.campus_id inner join departments d on d.id = drive.department_id where drive.id=#{drive_id}").first
			# :date_of_drive=>row[3]
			hash = {:address=>row[2],:no_of_students=>row[4].to_i,:department=>row[5],:description=>row[11],
					:contact_details=>{:hod_email=>row[6],:email_1=>row[7],:email_2=>row[8],:phone_1=>row[9],:phone_2=>row[10]}}
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
