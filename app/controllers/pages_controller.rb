class PagesController < ApplicationController
  def home
    @categories = Category.all
    @articles = Article.all.page(params[:page]).per(12)
    if params[:slug]
      @category = @categories.find_by(slug: params[:slug])
      @articles = @category.articles.page(params[:page]).per(12)
      @sel = @category.id
    end
    @categories = Category.all

    respond_to do |format|
      format.html
      format.js
    end
  end
end
