#
#
#
class Article 
  include MongoMapper::Document

  cattr_reader :per_page
  @@per_page = 25

  belongs_to :user
  belongs_to :category
  belongs_to :status
  
  # Attributes
  key :user_id,       ObjectId
  key :category_id,   ObjectId
  key :status_id,     ObjectId
                      
  key :thread,        String
  key :url,           String
  key :author,        String
  key :replies,       Integer
  key :authors        
  key :link_time,     Time  
  key :subject,       String
  key :time_assigned, Time 
  key :time_closed,   Time 
  timestamps!
  
  # Cached values
  key :user_nickname,  String
  key :status_name,    String
  key :category_name,  String
    
end # of class
