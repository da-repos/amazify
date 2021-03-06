class PagesController < ApplicationController
  def home
    @categories = Category.all
    @articles = Article.approved.page(params[:page]).per(12).order(created_at: :desc)
    @podcasts = Podcast.published.page(params[:page]).per(5).order(episode: :desc)
    if params[:slug]
      @category = @categories.find_by(slug: params[:slug])
      @articles = @category.articles.approved.page(params[:page]).per(12).order(created_at: :desc)
      @podcasts = @category.podcasts.published.page(params[:page]).per(5).order(episode: :desc)
      @slug = @category.slug
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def podcast
    @podcast = Podcast.find_by_slug(params[:slug])
    if @podcast.guests.include? ";"
      @guests = @podcast.guests.split ";"
    else
      @guests = [@podcast.guests]
    end
  end

  def privacy_policy
  end

end