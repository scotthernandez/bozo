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
#      @data_y << %'#{xs.articles[5,5]}'
    end
  end

  def gchart_articles
    l = []

    @data = User.find_by_sql("select count(*) as count , date_trunc('day', created_at) as articles  from articles group by articles order by articles")

    GoogleChart::LineChart.new("400x200", "Inflow of Articles", false) do |lc|
      @data.each { |d|
        l << d.count.to_i
        lc.data d.articles[5,5], [d.count.to_i], '000fff'
      }
     @x = lc.to_url
    end
    return @x
  end


  def get_daily_articles_chart_data
    return daily_articles
  end


end # of class
