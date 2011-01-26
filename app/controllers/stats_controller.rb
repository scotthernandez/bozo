#
#
class StatsController < ApplicationController

  #
  #
  #
  def index
    x = User.find_by_sql("select count(*) as count , date_trunc('day', created_at) as articles  from articles group by articles order by articles")
     
    map_function = %( function() {
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
    
    @current_date = Time.zone.today
    start_of_month = @current_date.beginning_of_month.beginning_of_day.utc
    end_of_month = @current_date.end_of_month.end_of_day.utc
    x = Article.collection.map_reduce( map_function, reduce_function, 
                                       {:query => {:created_at => {"$gte" => start_of_month, "$lte" => end_of_month }}} ).find().to_a
    
    @data_x = []
    @data_y = []
    x.each do |xs|
      @data_x <<  xs["value"].to_i
      @data_y << xs["_id"]
    end
  end


end # of class
