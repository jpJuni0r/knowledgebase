require 'net/https'
require 'uri'
require 'cgi'
require 'json'
require 'securerandom'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    params = article_params
    puts 'Params'
    puts params

    translation = translateArticle(params[:question], params[:answer])
    params = translation.merge(params)

    @article = Article.new(params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      params = article_params
      translation = translateArticle(params[:question], params[:answer])
      params = translation.merge(params)
      if @article.update(params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:question, :answer)
  end

  def translateArticle(question, answer)
    translatedArticle = {
      :question_de => translate(question),
      :answer_de => translate(answer)
    }
  end

  def translate(text)
    if ENV['TRANSLATE_API_KEY'].present?
      key = ENV['TRANSLATE_API_KEY']
      uri = URI('https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=en&to=de')

      content = [{
        :Text => text
      }].to_json

      request = Net::HTTP::Post.new(uri)
      request['Content-type'] = 'application/json'
      request['Content-length'] = content.length
      request['Ocp-Apim-Subscription-Key'] = key
      request['X-ClientTraceId'] = SecureRandom.uuid
      request.body = content

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request (request)
      end

      json = JSON.parse(response.body.force_encoding("utf-8"))

      translatedText = json[0]["translations"].select{|key, hash| key["to"] == 'de'}[0]['text']
      translatedText
    else
      'API key for translations not set'
    end

  end

end
