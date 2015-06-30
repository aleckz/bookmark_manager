env = ENV['RACK_ENV'] || 'development'

require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/bookmark_manager#{env}')

require_relative './models/link'

DataMapper.finalize

DataMapper.auto_upgrade!