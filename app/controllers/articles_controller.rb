class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = @current_user.Article.new(article_param)
    if @article.save
      flash[:notice] = "Article created"
      redirect_to articles_path(@article)
    else
      render :index
    end
  end

  def update
    if @article.update(article_param)
      flash[:notice] = "Article was successfully updated"
      redirect_to articles_path(@article)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully destroy"
    redirect_to articles_path(@article)
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end
    def article_param
      params.require(:article).permit(:title, :description)
    end
end
