class Articles < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 25

  belongs_to :user
  belongs_to :category
  belongs_to :status
end
