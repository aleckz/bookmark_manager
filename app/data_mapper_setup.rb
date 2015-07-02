env = ENV['RACK_ENV'] || 'development'

require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}")
# now that a database EXISTS in Heroku, which you create by googling Heroku PSQL database setup,
# all of this code is going to the Heroku database INSTEAD OF (||) localhost.
require_relative './models/link'
require_relative './models/tag'
require_relative './models/user'


DataMapper.finalize

DataMapper.auto_upgrade!