#
#
#
class Category
  include MongoMapper::Document
  
  many :categories

  
  key :name, String
  
end # of class
