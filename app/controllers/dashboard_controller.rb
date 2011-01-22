#
#
#
class DashboardController < ApplicationController
  
  #
  #
  #
  def index
    @articles_no_reply = Articles.paginate( :page => params[:page], :include => :user, :conditions => "replies = 0", :order => 'link_time DESC, id DESC')
    @articles_no_reply.delete_if{|a| a.status_id == 3}

#    @articles_no_reply = Articles.find(:all, :include => :user, :conditions => "replies = 0", :order => 'link_time DESC, id DESC')
#    @articles_no_reply.delete_if{|a| a.status_id == 3}

    @articles = Articles.paginate(:page => params[:page], :conditions => "replies != 0", :order => 'link_time DESC, id DESC')
    @articles.delete_if{|a| a.status_id == 3}

#    @articles = Articles.find(:all, :conditions => "replies != 0", :order => 'link_time DESC, id DESC')
#    @articles.delete_if{|a| a.status_id == 3}

    @closed_articles = Articles.find(:all,:order => 'link_time DESC, id DESC')
    @closed_articles.delete_if{|a| a.status_id != 3}

    @users = User.find(:all, :order => "id ASC")
    @cat = Category.find(:all)
  end

  
  #
  #
  #
#  def user
#     @users = User.find(:all, :order => "id asc")
#  end

  
  #
  #
  #
  def byuser
    if user_signed_in? then
      user_id = current_user.id
      @user = User.find_by_id(user_id)

      @articles_no_reply = Articles.find(:all, :include => :user, :conditions => "(replies = 0 and user_id = #{user_id})", :order => 'link_time DESC, id DESC')
      @articles_no_reply.delete_if{|a| a.status_id == 3}

      @articles = Articles.find(:all, :conditions => "replies != 0 and user_id = #{user_id}", :order => 'link_time DESC')
      @articles.delete_if{|a| a.status_id == 3}

      @closed_articles = Articles.find(:all, :conditions => "user_id = #{user_id}", :order => 'link_time DESC, id DESC')
      @closed_articles.delete_if{|a| a.status_id != 3}

      @users = User.find(:all, :order => "id ASC")
      @cat = Category.find(:all)
    end
  end

end # of class
