#
#
class StatsController < ApplicationController

  #
  #
  #
  def index
    x = User.find_by_sql("select count(*) as count , date_trunc('day', created_at) as articles  from articles group by articles order by articles")
    @data_x = []
    @data_y = []
    x.each do |xs|
      @data_x <<  xs.count.to_i
      @data_y << xs.articles[5,5]
    end
  end


end # of class
