class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

  require 'date'
  require 'nokogiri'
  require 'open-uri'

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all


    @debug = scrape 'http://blog.livedoor.jp/nwknews/index.rdf'
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name, :url, :rss, :active)
    end

    # --------------------------------------------------
    # scrape
    def scrape (uri)
      page = URI.parse(uri).read
      doc = Nokogiri::XML(open(uri))

      re = ''
      doc.search('item').each do |i|
        # new
        post = Post.new
        post.title = i.search('title').text
        post.url = i.search('link').text
        post.description = i.search('description').text
        # save
        add_db_create_or_refresh(post)

        re = post
      end

      re
    end

    def add_db_create_or_refresh(post)
      posts = Post.where(:url => post.url).first
      if posts.blank?
        post.save
      end
    end

end
