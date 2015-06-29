require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager")

require_relative './models/link'

DataMapper.finalize

DataMapper.auto_upgrade!