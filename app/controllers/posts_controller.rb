class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PW"] if Rails.env.production?
  
  # GET /posts
  # GET /posts.json
  def index
    # 
    # scrape_update

    # 
    info = {}

    if params[:category]
      category = Category.where(id: params[:category]).first
      ar = []
      category.sites.each do |i|
        ar.push i.id
      end
      @posts = Post.where(site_id: ar).order('posted_at DESC').page params[:page]
      info[:all] = Post.where(site_id: ar).order('posted_at DESC').count
    # elsif params[:type] == 'rate'
    #   # clicks = Click.all.order('count DESC')
    #   @posts = Post.all
    #   info[:all] = Post.all.count
    #   info[:count] = Post.where(id: 1).first.click.count
    else
      @posts = Post.all.order('posted_at DESC').page params[:page]
      info[:all] = Post.all.count
    end

    # jsonに情報を追加
    @posts_json = []

    # 
    info[:size] = 25
    info[:now] = params[:page] || 1
    info[:max] = (info[:all]/info[:size]).ceil + 1
    @posts_json.push info

    # 
    posts = []
    @posts.each do |i|
      site = Site.where(id: i.site_id).first
      click = Click.where(post_id: i.id).first
      post = {}
      post[:id] = i.id
      post[:title] = i.title
      post[:url] = i.url
      post[:description] = i.description
      post[:site] = site.name
      post[:time] = ApplicationController.helpers.foo_time(i.posted_at)
      if click
        post[:click] = click.count
      else
        post[:click] = 0
      end
      posts.push post
    end
    @posts_json.push posts

    respond_with(@posts) do |format|
      if Rails.env.development?
        format.html { render :html => @post }
      end
      format.json { render :json => @posts_json.as_json }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :url, :thumb, :remove_thumb, :thumb_cache, :site_id, :posted_at, :clicks)
    end
end


