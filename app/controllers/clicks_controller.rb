class ClicksController < ApplicationController
  before_action :set_click, only: [:show, :edit, :update, :destroy]
  respond_to :json
  http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PW"] if Rails.env.production?
  
  # GET /clicks
  # GET /clicks.json
  def index
    @clicks = Click.all
  end

  # GET /clicks/1
  # GET /clicks/1.json
  def show
  end

  # GET /clicks/new
  def new
    @click = Click.new
  end

  # GET /clicks/1/edit
  def edit
  end

  # POST /clicks
  # POST /clicks.json
  # def create
  #   @click = Click.new(click_params)

  #   respond_to do |format|
  #     if @click.save
  #       format.html { redirect_to @click, notice: 'Click was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @click }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @click.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # angulr用
  def create
    click = Click.new
    # click.count = 1
    url = params[:new_click][:url]
    post = Post.where(url: url).first
    if post
      click = Click.where(post_id: post.id).first
      if click
        click.update_attribute(:count, click.count+1)
        if click.valid?
          click.save!
        else
          render "public/422", :status => 422
          return
        end
      else
        click = Click.new
        click.count = 1
        click.post_id = post.id
        if click.valid?
          click.save!
        else
          render "public/422", :status => 422
          return
        end
      end
    else
      render "public/422", :status => 422
      return
    end

    respond_with(click) do |format|
      format.json { render :json => click.as_json }
    end
  end

  # PATCH/PUT /clicks/1
  # PATCH/PUT /clicks/1.json
  def update
    respond_to do |format|
      if @click.update(click_params)
        format.html { redirect_to @click, notice: 'Click was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @click.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clicks/1
  # DELETE /clicks/1.json
  def destroy
    @click.destroy
    respond_to do |format|
      format.html { redirect_to clicks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_click
      @click = Click.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def click_params
      params.require(:click).permit(:count, :post_id)
    end
end
