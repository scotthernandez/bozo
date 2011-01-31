#
#
#
class ArticlesController < ApplicationController

  respond_to :js

  before_filter :authenticate_user!
  
  #
  #
  #
  def update
    @article = Article.find(params[:id])

    if params[:category_id] != "-1"
      category = Category.find(params[:category_id])
      @article.category_id = category && category.id
      @article.category_name = category && category.name
    end
    
    if params[:user_id] != "-1"
      user = User.find(params[:user_id])
      @article.user_id       = user && user.id
      @article.user_nickname = user && user.nick      
      @article.time_assigned = user && (@article.time_assigned || Time.now) 
    end
    
    if params[:status_id] != "-1"
      status = Status.find(params[:status_id])
      @article.status_id   = status && status.id
      @article.status_name = status && status.name      
      @article.time_closed = status && ((status.name == "Closed") ? Time.now : nil) 
    end

    if @article.save
      flash[:success] = "Article updated."
    else
      flash[:error] = "Error saving article."
    end

    respond_with(@article)
  end
end
