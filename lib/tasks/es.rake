# command to run the below task
#  rake lib/tasks/es:create_mapping

desc "creating index mapping"
namespace :es do
  task create_mapping: :environment do
  	puts "---------"
  	config = ES::Configuration.new
  	config.create_mapping_company
  	puts "----------"
  end

end
