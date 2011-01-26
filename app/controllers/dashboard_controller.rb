#
#
#
class DashboardController < ApplicationController
  
  #
  #
  #
  def index
    closed_status = Status.find_by_name("Closed")
    
    @articles_no_reply = Article.where(:replies => 0).sort(:link_time.desc, :id.desc).all.paginate(:page => params[:page])
    @articles_no_reply.delete_if { |a| a.status_id == closed_status.id }

    @articles = Article.where(:replies.ne => 0).sort(:link_time.desc, :id.desc).all.paginate(:page => params[:page])
    @articles.delete_if { |a| a.status_id == closed_status.id }

    @closed_articles = Article.where(:status_id => closed_status.id).sort(:link_time.desc, :id.desc).all

    @users = User.all(:order => "id")
    @categories = Category.all
    @statuses = Status.all
  end

  
  #
  #
  #
  def byuser
    if user_signed_in? then
      user_id = current_user.id
      @user = User.find_by_id(user_id)
      closed_status = Status.find_by_name("Closed")      

      @articles_no_reply = Article.where({:replies => 0, :user_id => user_id}).sort(:link_time.desc, :id.desc).all
      @articles_no_reply.delete_if { |a| a.status_id == closed_status.id }

      @articles = Article.where({:replies.ne => 0, :user_id => user_id}).sort(:link_time.desc).all
      @articles.delete_if { |a| a.status_id == closed_status.id }

      @closed_articles = Article.where(:user_id => user_id, :status_id => closed_status.id).sort(:link_time.desc, :id.desc).all

      @users = User.all(:order => "id")
      @categories = Category.all
      @statuses = Status.all
    end
  end

end # of class
