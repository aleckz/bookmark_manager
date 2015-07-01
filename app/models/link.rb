require 'data_mapper'

class Link

  include DataMapper::Resource

  property :id,    Serial
  property :title, String # This is what ORM is --
  property :url,   String # it allows us to use the DataMapper DSL (domain-specific language - methods like 'property', 'has' 'n'Ruby
  # property :tag,   String # to relate to the database
  
  has n,   :tags, through: Resource

end



