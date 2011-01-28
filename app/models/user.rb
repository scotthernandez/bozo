#
#
#
class User
  include MongoMapper::Document  
  plugin MongoMapper::Devise
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
    
  # Attributes
  key :email,                 String
  key :encrypted_password,    String
  key :password_salt,         String
  key :reset_password_token,  String
  key :remember_token,        String
  key :remember_created_at,   Time
  key :sign_in_count,         Integer
  key :current_sign_in_at,    Time
  key :last_sign_in_at,       Time
  key :current_sign_in_ip,    String
  key :last_sign_in_ip,       String
  key :email_alert,           Boolean
  key :sms,                   Boolean
  key :weekend,               Boolean
  key :estime,                Time
  key :eetime,                Time
  key :sstime,                Time
  key :setime,                Time
  key :nick,                  String
  key :sms_address
  timestamps!
  
  # Validations
  REG_EMAIL_NAME   = '[\w\.%\+\-]+'
  REG_DOMAIN_HEAD  = '(?:[A-Z0-9\-]+\.)+'
  REG_DOMAIN_TLD   = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info)'
  REG_EMAIL_OK     = /\A#{REG_EMAIL_NAME}@#{REG_DOMAIN_HEAD}#{REG_DOMAIN_TLD}\z/i
  
  validates_length_of :email, :within => 6..100, :allow_blank => true
#  validates_format_of :email, :with => REG_EMAIL_OK, :allow_blank => true
  
end # of class
