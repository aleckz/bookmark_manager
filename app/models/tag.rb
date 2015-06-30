require 'data_mapper'

class Tag
  include DataMapper::Resource

  property :id,   Serial
  property :name, String
<<<<<<< HEAD
=======

  has n,   :links, through: Resource
>>>>>>> b931b81f1b57a60fe28cd464292de3876e3aa35d
end