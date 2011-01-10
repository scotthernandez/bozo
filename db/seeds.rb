# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Category.create(:name => '---')
Category.create(:name => 'Bug')
Category.create(:name => 'Doc')
Category.create(:name => 'Design')
Category.create(:name => 'Sales')

Status.create(:name => '---')
Status.create(:name => 'Open')
Status.create(:name => 'Closed')
Status.create(:name => 'Thanks')

User.create(:name => "---")
User.create(:name => "alvin")
User.create(:name => "aaron")
User.create(:name => "eliot")
User.create(:name => "kyle")
User.create(:name => "kristina")
User.create(:name => "richard")
User.create(:name => "mathias")
User.create(:name => "robert")
User.create(:name => "roger")
User.create(:name => "dwight")