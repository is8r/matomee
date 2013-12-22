class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  respond_to :json

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('posted_at DESC').page params[:page]

    # jsonに情報を追加
    @posts_json = []
    @posts.each do |i|
      site = Site.where(id: i.site_id).first
      
      post = {}
      post[:title] = i.title
      post[:url] = i.url
      post[:description] = i.description
      post[:site] = site.name
      post[:time] = ApplicationController.helpers.foo_time(i.posted_at)
      @posts_json.push post
    end

    respond_with(@posts) do |format|
      format.html { render :html => @post }
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

  # angulr用
  # def create
  #   # Create and save new post from data received from the client
  #   post = Post.new
  #   post.title = params[:new_post][:title][0...250] # Get only first 250 characters
  #   post.description = params[:new_post][:description]
  #   post.url = params[:new_post][:url]

  #   # Confirm post is valid and save or return HTTP error
  #   if post.valid?
  #     post.save!
  #   else
  #     render "public/422", :status => 422
  #     return
  #   end

  #   # Respond with newly created post in json format
  #   respond_with(post) do |format|
  #     format.json { render :json => post.as_json }
  #   end
  # end

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
      params.require(:post).permit(:title, :description, :url, :thumb, :remove_thumb, :thumb_cache, :site_id, :posted_at)
    end
end


