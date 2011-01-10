class Articles < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :status
end
