# Load the Rails application.
require_relative 'application'
# require "es/campus_sync"
# require 'es/campus_drive_sync'
require "#{Rails.root}/app/lib/es/configuration.rb"
require "#{Rails.root}/app/lib/es/campus_sync"
require "#{Rails.root}/app/lib/es/campus_drive_sync"


# Initialize the Rails application.
Rails.application.initialize!
