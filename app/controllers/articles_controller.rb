#
#
#
class ArticlesController < ApplicationController

  respond_to :js

  
  #
  #
  #
  def update
    @article = Articles.find(params[:id])

    @article.category_id  = params[:category_id] if params[:category_id] != "-1"
    @article.status_id    = params[:status_id]   if params[:status_id] != "-1"
    @article.user_id      = params[:user_id]     if params[:user_id] != "-1"

    if @article.save
      flash[:success] = "Article updated."
    else
      flash[:success] = "problem."
    end

    respond_with(@article)
  end
end
