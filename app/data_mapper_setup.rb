require 'data_mapper'
require 'dm-validations'


env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")

require './app/models/link.rb'
require './app/models/tag.rb'
require './app/models/user.rb'

DataMapper.finalize

DataMapper.auto_upgrade!
