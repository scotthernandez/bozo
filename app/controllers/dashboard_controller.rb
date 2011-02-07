#
#
#
class DashboardController < ApplicationController
  
   before_filter :authenticate_user!
  
  #
  #
  #
  def index
    closed_status = Status.find_by_name("Closed")
    
    @articles_no_reply = Article.where(:replies.lt => 1, 
                                       :status_id.ne => closed_status.id).sort(:link_time.desc, :id.desc).paginate(:page => params[:page])

    @articles = Article.where(:replies.gte => 1, 
                              :status_id.ne => closed_status.id).sort(:link_time.desc, :id.desc).paginate(:page => params[:page])

#    @closed_articles = Article.where(:status_id => closed_status.id).sort(:link_time.desc, :id.desc).paginate(:page => params[:page])

    @users = User.all(:order => "id")
    @categories = Category.all
    @statuses = Status.all
  end

  
  #
  #
  #
  def byuser
    user_id = current_user.id
    @user = User.find_by_id(user_id)
    closed_status = Status.find_by_name("Closed")      

    @articles_no_reply = Article.where({:replies.lt => 1, 
                                        :user_id => user_id, 
                                        :status_id.ne => closed_status.id}).sort(:link_time.desc, :id.desc).all

    @articles = Article.where({:replies.gte => 1, 
                               :user_id => user_id, 
                               :status_id.ne => closed_status.id}).sort(:link_time.desc).all

    @closed_articles = Article.where(:user_id => user_id, 
                                    :status_id => closed_status.id).sort(:link_time.desc, :id.desc).paginate(:page => params[:page])

    @users = User.all(:order => "id")
    @categories = Category.all
    @statuses = Status.all
  end

end # of class
