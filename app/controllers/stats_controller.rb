#
#
class StatsController < ApplicationController

  #
  #
  #
  def index

  end

  #
  #
  #
  def incoming_by_day
    map_function    = %( function() {
        var date = this.link_time;
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate(); 
        emit( m + "/" + d , 1); 
    })

    reduce_function = %( function(key, values) { 
      var total = 0; 
      for ( var i=0; i < values.length; i++ ) { 
        total += values[i]; 
      } 
      return total; 
    })

    @current_date   = Time.zone.today
    start_of_month  = @current_date.beginning_of_month.beginning_of_day.utc
    end_of_month    = @current_date.end_of_month.end_of_day.utc
    x               = Article.collection.map_reduce(map_function, reduce_function,
                                                    {:query => {:link_time => {"$gte" => start_of_month, "$lte" => end_of_month}}}).find().to_a

    @data_x = []
    @data_y = []
    x.each do |xs|
      @data_x << xs["_id"]
      @data_y << xs["value"].to_i
    end
  end


  #
  #
  #
  def closed_by_day
    closed_status   = Status.find_by_name('Closed')

    map_function    = %( function() {
        var date = this.time_closed;
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate(); 
        emit( m + "/" + d , 1); 
    })

    reduce_function = %( function(key, values) { 
      var total = 0; 
      for ( var i=0; i < values.length; i++ ) { 
        total += values[i]; 
      } 
      return total; 
    })

    @current_date   = Time.zone.today
    start_of_month  = @current_date.beginning_of_month.beginning_of_day.utc
    end_of_month    = @current_date.end_of_month.end_of_day.utc
    x               = Article.collection.map_reduce(map_function, reduce_function,
                                                    {:query => {:link_time => {"$gte" => start_of_month, "$lte" => end_of_month},
                                                                :status_id  => closed_status.id}}).find().to_a

    @data_x = []
    @data_y = []
    x.each do |xs|
      @data_x << xs["_id"]
      @data_y << xs["value"].to_i
    end
  end


  #
  #
  #
  def incoming_by_hour
    @current_date   = Time.zone.today
    start_date      = (@current_date - @current_date.wday).beginning_of_day.utc
    end_date        = (@current_date - @current_date.wday + 6).end_of_day.utc
    articles        = Article.where({:link_time => {"$gte" => start_date, "$lte" => end_date}}).all

    @day_stats = []

    articles_group = articles.group_by { |x| x.link_time.to_date }
    articles_group.keys.sort.each do |k|
      values = articles_group[k]
      time_map = {}
      0.upto(23).each { |i| time_map[i] = 0 }

      values.each do |value| 
        time_map[value.link_time.hour] += 1
      end
      
      @day_stats << {:label => l(k.to_date, :format => :wday_and_short_date), :stats => time_map}      
    end
    
    # Add weekly average
    @avg_stats = { :label => "Weekly Average" }
    time_map = {}

    # collect average for each hour
    0.upto(23).each do |i|
      incoming_total = 0.0
      
      # go over each day (same time)
      @day_stats.each do |stats_map| 
        incoming_total += stats_map[:stats][i]
      end
      
      time_map[i] = (incoming_total / @day_stats.size)  
    end
    
    @avg_stats[:stats] = time_map
    @day_stats << @avg_stats
  end
  
  
  #
  #
  #
  def close_time_by_day
    closed_status   = Status.find_by_name('Closed')

    map_function    = %( function() {
        var date = this.time_closed;
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate(); 
        emit( m + "/" + d , (date - this.link_time) / 3600000); 
    })

    reduce_function = %( function(key, values) { 
      var total = 0; 
      for ( var i=0; i < values.length; i++ ) { 
        total += values[i]; 
      } 
      return (total / values.length); 
    })

    @current_date   = Time.zone.today
    start_of_month  = @current_date.beginning_of_month.beginning_of_day.utc
    end_of_month    = @current_date.end_of_month.end_of_day.utc
    x               = Article.collection.map_reduce(map_function, reduce_function,
                                                    {:query => {:link_time => {"$gte" => start_of_month, "$lte" => end_of_month},
                                                                :status_id  => closed_status.id}}).find().to_a

    @data_x = []
    @data_y = []
    x.each do |xs|
      @data_x << xs["_id"]
      @data_y << xs["value"].to_i
    end
  end

end # of class
