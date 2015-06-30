env = ENV['RACK_ENV'] || 'development'

require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/bookmark_manager#{env}')
# now that a database EXISTS in Heroku, which you create by googling Heroku PSQL database setup, 
# all of this code is going to the Heroku database INSTEAD OF (||) localhost.
require_relative './models/link'
require_relative './models/tag'

DataMapper.finalize

DataMapper.auto_upgrade!