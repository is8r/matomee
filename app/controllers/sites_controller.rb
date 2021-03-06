class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  # http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PW"] if Rails.env.production?
  
  require 'date'
  require 'nokogiri'
  require 'open-uri'
  require 'time'

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all.order(:created_at)

    # @debug = scrape_all
    # @debug = scrape 'http://workingnews.blog117.fc2.com/?xml'
    
    # @spreadsheet = GoogleSpreadsheets::Enhanced::Spreadsheet.find('0ArhV7gTgs6Z8dHlSRUF2SzFXWjlkU1V2d29KR2pkdXc')
    # @worksheet = @spreadsheet.worksheets.find_by(title: 'site_rows')
    # @rows = @worksheet.rows
    # @site_rows = Site.site_rows
    
    # 同期実行
    # Site.sync_with_site_rows

    # スクレイピング
    # ApplicationController.helpers.scrape_update
    # ApplicationController.helpers.scrape "http://alfalfalfa.com/index.rdf"

    respond_to do |format|
      if Rails.env.development?
        format.html { render :html => @sites }
      end
      format.json { render :json => @sites.as_json }
    end
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
      params.require(:site).permit(:name, :url, :rss, :active, :category_id)
    end

end
