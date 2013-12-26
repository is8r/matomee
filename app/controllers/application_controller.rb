class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #helper_method :current_user
  http_basic_authenticate_with :name => ENV["BASIC_AUTH_NAME"], :password => ENV["BASIC_AUTH_PW"] if Rails.env.production?
  
  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    # --------------------------------------------------
    # --------------------------------------------------
    # scrape
    def scrape_all
      sites = Site.all
      sites.each do |i|
        scrape i.rss
      end
    end

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
        post.posted_at = Time.parse(i.xpath('dc:date').text)
        post.site_id = get_site_id_rss(uri)

        # save
        add_db_create_or_update(post)

        # re = post
      end

      re
    end

    # helper?
    def get_site_id_rss(rss)
      site = Site.where(rss: rss).first
      re = 0
      unless site.blank?
        re = site.id
      end
      re
    end

    # model?
    def add_db_create_or_update(post)
      posts = Post.where(:url => post.url).first
      if posts.blank?
        post.save
      else
        if posts.site_id.blank? || post.site_id < 1
          posts.update_attribute(:site_id, post.site_id)
        end
        if posts.posted_at.blank? || post.posted_at
          posts.update_attribute(:posted_at, post.posted_at)
        end
      end
    end

end
