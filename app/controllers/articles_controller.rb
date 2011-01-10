class ArticlesController < ApplicationController
  def update
    @article = Articles.find(params[:id])

    @article.category_id = params["article"]["category_id"]
    @article.status_id = params["article"]["status_id"]
    @article.user_id = params["article"]["user_id"]

    if @article.save
      flash[:success] = "Article updated."
    else
      flash[:success] = "problem."
    end
    redirect_to "/dashboard/index"
  end
end
