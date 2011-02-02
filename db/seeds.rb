# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Category.create(:name => 'Bug')
Category.create(:name => 'Doc')
Category.create(:name => 'Design')
Category.create(:name => 'Sales')
Category.create(:name => 'Question')

Status.create(:name => 'Open')
Status.create(:name => 'Closed')
Status.create(:name => 'Thanks')


