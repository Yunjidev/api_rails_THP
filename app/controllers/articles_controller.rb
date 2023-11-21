class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_article, only: [:show, :update, :destroy]
  before_action :check_id, only: [:update, :destroy]
  before_action :check_private, only: [:show]

  # GET /articles
  def index
    # Récupère tous les articles non privés
    @articles = Article.where(private: false)
    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content, :private)
    end

    def check_id
      render json: {message: "Unauthorized! Only the author can do that"}, status: :unauthorized unless current_user == @article.user
    end

    def check_private
      render json: {message: "This is a private article, you must be the author to see it!"}, status: :unauthorized unless current_user == @article.user
    end
end