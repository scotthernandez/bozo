#
#
#
class Status
  include MongoMapper::Document
  
  many :articles
  
  
  key :name, String
  
end # of class
